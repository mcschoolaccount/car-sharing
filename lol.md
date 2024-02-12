## **Wypożyczalnia samochodów**
Dokumentacja opisuje strukturę i funkcje bazy danych obsługującej wypożyczanie samochodów.  
Baza danych została zaprojektowana w celu zarządzania wypożyczalnią samochodów

### Tabele
1. **klienci**
   - Pola: id `int`, imie `varchar(255)`, nazwisko `varchar(255)`, numer_telefonu `varchar(15)`, ulica `varchar(255)`, miasto `varchar(255)`, kod_pocztowy `varchar(5)`, prawo_jazdy `varchar(255)` 

2. **placowki**
   - Pola: id `int`, imie `varchar(255)`, ulica `varchar(255)`, miasto `varchar(255)`, wojewodztwo `varchar(255)`, kraj `varchar(255)`, kod_pocztowy `varchar(5)`

3. **platnosci**
   - Pola: id `int`, data `datetime`, kwota `int`, rezerwacja_id `int`

4. **pojazdy**
   - Pola: id `int`, typ `enum`, placowka_id `int`, ubezpieczenie_id `int`, vin `varchar(50)`, dostepnosc `enum`, marka `varchar(255)`, model `varchar(255)`, rok_produkcji `year`, przebieg `int`, koszt `decimal`, siedzenia `int`

5. **pracownicy**
   - Pola: id `int`, placowka_id `int`, imie `varchar(255)`, nazwisko `varchar(255)`, data_urodzenia `date`, ulica `varchar(255)`, miasto `varchar(255)`, kod_pocztowy `varchar(5)`, zarobki `int`, pozycja `enum`

6. **rezerwacje**
   - Pola: id `int`, klient_id `int`, pojazd_id `int`, lokacja_odbioru `int`, lokacja_zwrotu `int`, data_odbioru `date`, data_zwrotu `date` 

7. **ubezpieczenia**
    - Pola: id `int`, imie `varchar(255)`, polisa `varchar(255)`, koszt `decimal`

8. **wypozyczenia**
    - Pola: id `int`, pracownik_id `int`, placowka_id `int`, rezerwacja_id `int`

### Widoki
1. **ilosc_samochodow_po_dostepnosci**
   - Pola: dostepnosc `enum`, amount `bigint`
   - Opis: Liczba samochodów w zależności od dostępności.

2. **ilosc_samochodow_po_typie**
   - Pola: typ `enum`, amount `bigint`
   - Opis: Liczba samochodów w zależności od typu.

3. **piec_najaktywniejszych_klientow**
   - Pola: id `int`, imie `varchar(255)`, nazwisko `varchar(255)`, numer_telefonu `varchar(15)`, ulica `varchar(255)`, miasto `varchar(255)`, kod_pocztowy `varchar(5)`, prawo_jazdy `varchar(255)`, reservation_amount `bigint`
   - Opis: Pięciu najaktywniejszych klientów.

### Procedury
1. **departamenty_po_kodzie_pocztowym**
   - Parametry: `kod_pocztowy VARCHAR(5)`
   - Opis: Pobierz departamenty na podstawie kodu pocztowego.

2. **dostepne_samochody_w_przedziale_cenowym**
   - Parametry: `min_value INT, max_value INT`
   - Opis: Pobierz dostępne samochody w określonym przedziale cenowym.

3. **najczesciej_uzywane_auto**
   - Opis: Pobierz najczęściej używany samochód.

4. **pojazdy_po_vin**
   - Parametry: `vin VARCHAR(50)`
   - Opis: Pobierz pojazdy na podstawie numeru identyfikacyjnego VIN.

5. **pojazdy_zarezerwowane_w_dniach**
   - Parametry: `data_odbioru DATE, data_zwrotu DATE`
   - Opis: Pobierz zarezerwowane pojazdy w określonych datach.

6. **polisy_po_vin_pojazdu**
   - Parametry: `vin VARCHAR(50)`
   - Opis: Pobierz polisy ubezpieczeniowe na podstawie numeru identyfikacyjnego VIN pojazdu.

7. **przychod_w_danym_roku_i_miesiacu**
   - Parametry: `p_year INT, p_month ENUM`
   - Opis: Pobierz przychód dla określonego roku i miesiąca.

8. **samochody_wynajete_przez_pracownika**
   - Parametry: `imie VARCHAR(255), nazwisko VARCHAR(255)`
   - Opis: Pobierz samochody wynajęte przez pracownika.

9. **samochody_wypozyczone_przez_klienta**
   - Parametry: `imie VARCHAR(255), nazwisko VARCHAR(255), numer_telefonu INT(15)`
   - Opis: Pobierz samochody wypożyczone przez klienta.

10. **samochody_w_departamencie**
    - Parametry: `dep_id INT`
    - Opis: Pobierz samochody w określonym departamencie.

### Podsumowanie
Ta dokumentacja zawiera kompleksowy opis bazy danych "wypożyczalnia samochodów", obejmujący procedury, tabele i widoki wraz z ich strukturami i opisami.
