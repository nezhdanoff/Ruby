# Edward Nezhdanoff (c) nezhdanoff@ukr.net
=begin
Программа принимает два параметра Unix TimeStamp в секундах.
Параметры можно передать в командной строке или ввести интерактивно
с системного устройства ввода STDIN.
Недостающие параметры, не переданные в командной строке будут запрошены в диалоговом режиме.
Все символы, отличные от цифр удаляются из вводимых данных, оставляя лишь последовательность цифр,
для исключения ошибочного ввода пользователем.
При получении пустой строки в качестве вводимых данных программа завершается принудительно по причине
невозможности вычислить разницу данных.
=end 

=begin
________Примеры вызова программы с разным сочетанием параметров и результаты работы_______________
C:\Users\Ed>DiffTime.rb 1478779621 1478687791
Well, we have the first Date value from command line and it is equal to:
1478779621
The second Date value is
1478687791

The difference between the dates is equal to:
91830 Seconds.

1 day 1 hour 30 minutes and 30 seconds

C:\Users\Ed>DiffTime.rb 35265841 1
Well, we have the first Date value from command line and it is equal to:
35265841
The second Date value is
1

The difference between the dates is equal to:
35265840 Seconds.

408 days 4 hours 4 minutes

C:\Users\Ed>DiffTime.rb 65841
Well, we have the first Date value from command line and it is equal to:
65841
Please enter the second Date value in Unix TimeStamp format
For example: 1478687791
and press "ENTER"
1
YES!!! The second Date value is
1


The difference between the dates is equal to:
65840 Seconds.

0 days 18 hours 17 minutes and 20 seconds

C:\Users\Ed>DiffTime.rb
Commandline parameters is empty
Please enter the first Date value in Unix TimeStamp format
For example: 1478687791
and press "ENTER"
1478779621
YES!!! The first Date value is
1478779621

Please enter the second Date value in Unix TimeStamp format
For example: 1478687791
and press "ENTER"
1478687791
YES!!! The second Date value is
1478687791


The difference between the dates is equal to:
91830 Seconds.

1 day 1 hour 30 minutes and 30 seconds

C:\Users\Ed>
=end

def checkDateInput(s)
# Параметр s определяет слово,(first или second) которое будет вставлено 
# в выводе сообщения о переменной Date 
# Используем метод getDate(s) для получения даных от пользователя
 	if (result = getDate(s)).empty?  then	# проверим на ввод пустой строки
		puts "Sorry. The #{s} Date value is empty."	# Выводим сообщение об ошибочном вводе пустой строки
		puts 'Programm aborted.'	# Продолжение работы не имеет смысла
		exit	# Принудительный выход из программы при получении пустой строки
	else 
		puts "YES!!! The #{s} Date value is \n#{result}\n\n"
		result.to_i	# Возвращаем непустое значение, приводя его к типу INTEGER
	end
end  
 
def getDate(s)
# Используем STDIN для получения числового значения
# Параметр s определяет подстроку,(например "first" или "second") которая будет вставлена 
# в описание переменной Date при запросе ввода числа
		puts "Please enter the #{s} Date value in Unix TimeStamp format"
		puts 'For example: 1478687791'
		puts 'and press "ENTER"'
		$stdin.gets.chomp.strip.scan(/\d/).join
# При вводе данных с консоли обрезаем и удаляем все символы, кроме цифр, которые склеиваем в одно число
end

# If a command line parameter is present and contain the first Date value.
if ARGV[0] then
	$firstDate =  ARGV[0].scan(/\d/).join.to_i
	puts 'Well, we have the first Date value from command line and it is equal to:'
	puts $firstDate.to_s
# And if command line contain the second Date value
	if ARGV[1] then
		$secondDate =  ARGV[1].scan(/\d/).join.to_i 
		puts "The second Date value is \n#{$secondDate.to_s}\n"
	else
		$secondDate = checkDateInput("second")
	end
else
# If command line contains no data parameters, we need get Date value manualy? from STDIN.
	puts 'Commandline parameters is empty'
	$firstDate = checkDateInput("first")
	$secondDate = checkDateInput("second")
end

	$diff = ($firstDate - $secondDate).to_i.abs # The difference between Date values in seconds
	puts "\nThe difference between the dates is equal to:\n"
	puts ($diff.to_s + ' Seconds.') , "\n"
	days = ($diff / (60 * 60 * 24)).to_i
	hours = ($diff / (60 * 60) - days * 24).to_i
	minutes = ($diff / 60 - days * 60 * 24 - hours * 60).to_i
	seconds = ($diff % 60).to_i
=begin	
# Блок, скрывающий нулевые значения дней, часов, минут 
# Снять комментарий и закомментировать альтернативный блок
	s_output = days > 0 ? (days.to_s + " day") + (days > 1 ? "s " : " ") : ""
	s_output += hours > 0 ? (hours.to_s + " hour") + (hours > 1 ? "s " : " ") : ""
	s_output += minutes > 0 ? (minutes.to_s + " minute") + (minutes > 1 ? "s " : " ") : ""
	s_output += seconds > 0 ? ("and " + seconds.to_s + " second") + (seconds > 1 ? "s " : " ") : ""
=end

#=begin
# Блок, выводящий нулевые значения дней, часов, минут
# Снять комментарий и закомментировать альтернативный блок
	s_output = days.to_s + " day" + (days != 1 ? "s " : " ") 
	s_output += hours.to_s + " hour" + (hours != 1 ? "s " : " ")
	s_output += minutes.to_s + " minute" + (minutes != 1 ? "s " : " ")
	s_output += seconds > 0 ? ("and " + seconds.to_s + " second") + (seconds > 1 ? "s " : " ") : ""
#=end

	puts s_output


