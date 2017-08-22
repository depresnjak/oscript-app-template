///////////////////////////////////////////////////////////////////////////////
//
// Служебный модуль с набором служебных параметров приложения
//
// При создании нового приложения обязательно внести изменение 
// в ф-ии ИмяПродукта, указав имя вашего приложения.
//
// При выпуске новой версии обязательно изменить ее значение
// в ф-ии ВерсияПродукта
//
///////////////////////////////////////////////////////////////////////////////

// ИмяПродукта
//	Возвращает имя продукта
//
// Возвращаемое значение:
//   Строка   - Значение имени продукта
//
Функция ИмяПродукта() Экспорт
	
	Возврат "oscript-app-template";
	
КонецФункции // ИмяПродукта

//	Возвращает идентификатор лога приложения
//
// Возвращаемое значение:
//   Строка   - Значение идентификатора лога приложения
//
Функция ИмяЛогаСистемы() Экспорт
	
	Возврат "oscript.app." + ИмяПродукта();
	
КонецФункции // ИмяЛогаСистемы

//	Возвращает текущую версию продукта
//
// Возвращаемое значение:
//   Строка   - Значение текущей версии продукта
//
Функция ВерсияПродукта() Экспорт
	
	Возврат "1.0";
	
КонецФункции // ВерсияПродукта

//	Форматирование логов
//
Функция Форматировать(Знач Уровень, Знач Сообщение) Экспорт

	Возврат СтрШаблон("%1: %2 - %3", ТекущаяДата(), УровниЛога.НаименованиеУровня(Уровень), Сообщение);

КонецФункции

// ПриРегистрацииКомандПриложения
//	Регистрирует классы обрабатывающие команды прилоложения
// 
// Параметры:
//	КлассыРеализацииКоманд - Соответствие - хранилище команд и классов
Процедура НастроитьКомандыПриложения(Знач КлассыРеализацииКоманд) Экспорт
	
	КлассыРеализацииКоманд["help"]				= "КомандаСправкаПоПараметрам";
	КлассыРеализацииКоманд[ИмяКомандыВерсия()]	= "КомандаVersion";
	//...
	//КлассыРеализацииКоманд["<имя команды>"]	= "<КлассРеализации>";
	
КонецПроцедуры // ПриРегистрацииКомандПриложения

// ИмяКомандыПоУмолчанию
// 	Одна из команд может вызываться неявно, без указания команды.
// 	Иными словами, здесь указывается какой обработчик надо вызывать, если приложение запущено без какой-либо команды
// 	myapp /home/user/somefile.txt будет аналогично myapp default-action /home/user/somefile.txt 
//
// Возвращаемое значение:
// 	Строка - имя команды по умолчанию
Функция ИмяКомандыПоУмолчанию() Экспорт
	
	// Возврат "default-action";
	Возврат ИмяКомандыВерсия();
	
КонецФункции // ИмяКомандыПоУмолчанию

// Возвращает имя команды версия (ключ командной строки)
//
//  Возвращаемое значение:
//   Строка - имя команды
//
Функция ИмяКомандыВерсия() Экспорт
	
	Возврат "version";

КонецФункции // ИмяКомандыВерсия
