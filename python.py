import logging
import re

import paramiko

host = '10.0.2.15'
port = '22'
username = 'kali'
password = 'kali'

from telegram import Update, ForceReply
from telegram.ext import Updater, CommandHandler, MessageHandler, Filters, ConversationHandler


TOKEN = "5725657007:AAH-G1CdWkF-8WyTN4M_HhLddCeJK8NzLZU"


# Подключаем логирование
logging.basicConfig(
    filename='logfile.txt', format='%(asctime)s - %(name)s - %(levelname)s - %(message)s', level=logging.INFO
)

logger = logging.getLogger(__name__)


def start(update: Update, context):
    user = update.effective_user
    update.message.reply_text(f'Привет {user.full_name}!')


def helpCommand(update: Update, context):
    text = "/find_email - email search\n"
    text += "/find_phone_number - phone number search\n"
    text += "/verify_password - check how strong your password\n"
    text += "/get_release - get relese connected os\n"
    text += "/get_uname - processor architecture, hostname and core version\n"
    text += "\n"
    text += "\n"
    text += "\n"
    text += "\n"
    text += "\n"
    text += "\n"
    text += "\n"
    update.message.reply_text(text)


def findPhoneNumbersCommand(update: Update, context):
    update.message.reply_text('Введите текст для поиска телефонных номеров: ')

    return 'find_phone_number'

def findEmailCommand(update: Update, context):
    update.message.reply_text('Введите текст для поиска e-mail: ')

    return 'find_email'

def verify_passwordCommand(update: Update, context):
    update.message.reply_text('Введите пароль для проверки на надежность: ')

    return 'verify_password'

def find_phone_number (update: Update, context):
    user_input = update.message.text # Получаем текст, содержащий(или нет) номера телефонов

    phoneNumRegex = re.compile(r'\+?\d[\( -]?[\( -]?\d{3}[\) -]?[\( -]?\d{3}[ -]?\d{2}[ -]?\d{2}')

    phoneNumberList = phoneNumRegex.findall(user_input) # Ищем номера телефонов

    if not phoneNumberList: # Обрабатываем случай, когда номеров телефонов нет
        update.message.reply_text('Телефонные номера не найдены')
        return # Завершаем выполнение функции
    
    phoneNumbers = '' # Создаем строку, в которую будем записывать номера телефонов

    for i in range(len(phoneNumberList)):
        phoneNumbers += f'{i+1}. {phoneNumberList[i]}\n' # Записываем очередной номер

    update.message.reply_text(phoneNumbers) # Отправляем сообщение пользователю
    return ConversationHandler.END # Завершаем работу обработчика диалога

def find_email (update: Update, context):
    user_input = update.message.text # Получаем текст, содержащий(или нет) номера телефонов

    emailRegex = re.compile(r'\S+@\w+\.\w+')

    emailList = emailRegex.findall(user_input) # Ищем номера телефонов

    if not emailList: # Обрабатываем случай, когда номеров телефонов нет
        update.message.reply_text('Email не найдены')
        return # Завершаем выполнение функции
    
    emails = '' # Создаем строку, в которую будем записывать номера телефонов

    for i in range(len(emailList)):
        emails += f'{i+1}. {emailList[i]}\n' # Записываем очередной номер

    update.message.reply_text(emails) # Отправляем сообщение пользователю
    return ConversationHandler.END # Завершаем работу обработчика диалога

def verify_password (update: Update, context):
    user_input = update.message.text # Получаем текст

    passwordRegex = re.compile(r'(?=.*\d)(?=.*[a-z])(?=.*[A-Z])(?=.*[!@#$%^&*()]).{8,}')

    verified_password = passwordRegex.search(user_input) 

    if not verified_password:
        answer = "Пароль простой"
    else:
        answer = "Пароль сложный"

    update.message.reply_text(answer) # Отправляем сообщение пользователю
    return ConversationHandler.END # Завершаем работу обработчика диалога

def ssh_execute_command (command):
    client = paramiko.SSHClient()
    client.set_missing_host_key_policy(paramiko.AutoAddPolicy())
    client.connect(hostname=host, username=username, password=password, port=port)
    stdin, stdout, stderr = client.exec_command(command)
    data = stdout.read() + stderr.read()
    client.close()
    data = str(data).replace('\\n', '\n').replace('\\t', '\t')[2:-1]
    return(data)

def get_release (update: Update, context):
    out = ssh_execute_command("uname -r").replace("\n","")
    result = f"Connected system relese is \"{out}\""
    update.message.reply_text(result)

def get_uname (update: Update, context):
    processor = ssh_execute_command("uname -m").replace("\n","")
    node = ssh_execute_command("uname -n").replace("\n","")
    core_ver = ssh_execute_command("uname -v").replace("\n","")
    result = f"Architecture is \"{processor}\", hostname is \"{node}\" and core version is \"{core_ver}\""
    update.message.reply_text(result)

def echo(update: Update, context):
    update.message.reply_text(update.message.text)

def main():
    updater = Updater(TOKEN, use_context=True)

    # Получаем диспетчер для регистрации обработчиков
    dp = updater.dispatcher

    # Обработчик диалога
    convHandlerFindPhoneNumbers = ConversationHandler(
        entry_points=[CommandHandler('find_phone_number', findPhoneNumbersCommand)],
        states={
            'find_phone_number': [MessageHandler(Filters.text & ~Filters.command, find_phone_number)],
        },
        fallbacks=[]
    )
	    
    convHandlerFindEmail = ConversationHandler(
        entry_points=[CommandHandler('find_email', findEmailCommand)],
        states={
            'find_email': [MessageHandler(Filters.text & ~Filters.command, find_email)],
        },
        fallbacks=[]
    )

    convHandlerVerifyPassword = ConversationHandler(
        entry_points=[CommandHandler('verify_password', verify_passwordCommand)],
        states={
            'verify_password': [MessageHandler(Filters.text & ~Filters.command, verify_password)],
        },
        fallbacks=[]
    )

	# Регистрируем обработчики команд
    dp.add_handler(CommandHandler("start", start))
    dp.add_handler(CommandHandler("help", helpCommand))
    dp.add_handler(convHandlerFindPhoneNumbers)
    dp.add_handler(convHandlerFindEmail)
    dp.add_handler(convHandlerVerifyPassword)
    dp.add_handler(CommandHandler("get_release", get_release))
    dp.add_handler(CommandHandler("get_uname", get_uname))
    # dp.add_handler(CommandHandler("get_uptime", get_uptime))
    # dp.add_handler(CommandHandler("get_df", get_df))
    # dp.add_handler(CommandHandler("get_free", get_free))
    # dp.add_handler(CommandHandler("get_mpstat", get_mpstat))
    # dp.add_handler(CommandHandler("get_w", get_w))
    # dp.add_handler(CommandHandler("get_auths", get_auths))
    # dp.add_handler(CommandHandler("get_ps", get_ps))
    # dp.add_handler(CommandHandler("get_ss", get_ss))
    # dp.add_handler(CommandHandler("get_apt_list", get_apt_list))
    # dp.add_handler(CommandHandler("get_services", get_services))
	# Регистрируем обработчик текстовых сообщений
    dp.add_handler(MessageHandler(Filters.text & ~Filters.command, echo))
		
	# Запускаем бота
    updater.start_polling()

	# Останавливаем бота при нажатии Ctrl+C
    updater.idle()


if __name__ == '__main__':
    main()
