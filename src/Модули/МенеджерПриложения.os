///////////////////////////////////////////////////////////////////////////////
//
// Служебный модуль с набором методов работы с командами приложения
//
// В большинстве проектов изменять данный модуль не требуется
//
///////////////////////////////////////////////////////////////////////////////

#Использовать logos
#Использовать tempfiles

///////////////////////////////////////////////////////////////////

Перем Лог Экспорт;

Перем ИсполнителиКоманд;
Перем РегистраторКоманд;
Перем ДополнительныеПараметры;
	
///////////////////////////////////////////////////////////////////

//	Инициализирует и настраивает лог приложения
// 
// Параметры:
//	УровеньЛогаСтрока - Строка - уровень логов, выводимых в консоль при выполнении скрипта
//
// Возвращаемое значение:
//   Лог   - Инициализированный лог, готовый к использованию
//
Функция ИнициализироватьЛог(Знач Настройки) Экспорт
	
		Лог = Логирование.ПолучитьЛог(Настройки.ИмяЛогаСистемы());
		Лог.УстановитьУровень(УровниЛога.Информация);
		Лог.УстановитьРаскладку(Настройки);
	
		Возврат Лог;
	
	КонецФункции
	
	//	Возвращает лог приложения
	// 
	// Возвращаемое значение:
	//   Лог   - Текущий лог приложения
	//
	Функция ПолучитьЛог() Экспорт
	
		Возврат Лог;
	
	КонецФункции

Процедура ЗарегистрироватьКоманды(Знач Парсер) Экспорт
	
	КомандыИРеализация = Новый Соответствие;
	РегистраторКоманд.ПриРегистрацииКомандПриложения(КомандыИРеализация);

	Для Каждого КлючИЗначение Из КомандыИРеализация Цикл

		ДобавитьКоманду(КлючИЗначение.Ключ, КлючИЗначение.Значение, Парсер);

	КонецЦикла;
	
КонецПроцедуры // ЗарегистрироватьКоманды

Процедура РегистраторКоманд(Знач ОбъектРегистратор) Экспорт
	
	ИсполнителиКоманд = Новый Соответствие;	
	РегистраторКоманд = ОбъектРегистратор;
	ДополнительныеПараметры = Новый Структура;

	ДополнительныеПараметры.Вставить("Лог", Логирование.ПолучитьЛог(ПараметрыПриложения.ИмяЛогаСистемы()));

КонецПроцедуры // РегистраторКоманд

Функция ПолучитьКоманду(Знач ИмяКоманды) Экспорт
	
	КлассРеализации = ИсполнителиКоманд[ИмяКоманды];
	Если КлассРеализации = Неопределено Тогда

		ВызватьИсключение СтрШаблон("Неверная операция. Команда '%1' не предусмотрена.", ИмяКоманды);

	КонецЕсли;
	
	Возврат КлассРеализации;
	
КонецФункции // ПолучитьКоманду

Функция ВыполнитьКоманду(Знач ИмяКоманды, Знач ПараметрыКоманды) Экспорт
	
	Команда = ПолучитьКоманду(ИмяКоманды);
	КодВозврата = Команда.ВыполнитьКоманду(ПараметрыКоманды, ДополнительныеПараметры);
	
	Возврат КодВозврата;

КонецФункции // ВыполнитьКоманду

Процедура ПоказатьСправкуПоКомандам(ИмяКоманды = Неопределено) Экспорт

	ПараметрыКоманды = Новый Соответствие;
	Если ИмяКоманды <> Неопределено Тогда

		ПараметрыКоманды.Вставить("Команда", ИмяКоманды);

	КонецЕсли;

	ВыполнитьКоманду("help", ПараметрыКоманды);

КонецПроцедуры // ПоказатьСправкуПоКомандам

Процедура ДобавитьКоманду(Знач ИмяКоманды, Знач КлассРеализации, Знач Парсер)
	
	Попытка
		
		РеализацияКоманды = Новый(КлассРеализации);
		РеализацияКоманды.ЗарегистрироватьКоманду(ИмяКоманды, Парсер);
		ИсполнителиКоманд.Вставить(ИмяКоманды, РеализацияКоманды);

	Исключение
		
		ДополнительныеПараметры.Лог.Ошибка("Не удалось выполнить команду '%1' для класса '%2'", ИмяКоманды, КлассРеализации);
		ВызватьИсключение;

	КонецПопытки;

КонецПроцедуры

///////////////////////////////////////////////////////////////////

Функция РезультатыКоманд() Экспорт

	РезультатыКоманд = Новый Структура;
	РезультатыКоманд.Вставить("Успех", 0);
	РезультатыКоманд.Вставить("НеверныеПараметры", 5);
	РезультатыКоманд.Вставить("ОшибкаВремениВыполнения", 1);
	
	Возврат РезультатыКоманд;

КонецФункции // РезультатыКоманд

Функция КодВозвратаКоманды(Знач Команда) Экспорт

	Возврат Число(Команда);

КонецФункции // КодВозвратаКоманды
