## **Wypożyczalnia samochodów**
Dokumentacja opisuje strukturę i funkcje bazy danych obsługującej wypożyczanie samochodów.  
Baza danych została zaprojektowana w celu zarządzania wypożyczalnią samochodów

### Tabele
1. **klienci**
   - Pola: id `INT`, imie `VARCHAR(255)`, nazwisko `VARCHAR(255)`, numer_telefonu `VARCHAR(15)`, ulica `VARCHAR(255)`, miasto `VARCHAR(255)`, kod_pocztowy `VARCHAR(5)`, prawo_jazdy `VARCHAR(255)` 

2. **placowki**
   - Pola: id `INT`, imie `VARCHAR(255)`, ulica `VARCHAR(255)`, miasto `VARCHAR(255)`, wojewodztwo `VARCHAR(255)`, kraj `VARCHAR(255)`, kod_pocztowy `VARCHAR(5)`

3. **platnosci**
   - Pola: id `INT`, data `datetime`, kwota `INT`, rezerwacja_id `INT`

4. **pojazdy**
   - Pola: id `INT`, typ `ENUM`, placowka_id `INT`, ubezpieczenie_id `INT`, vin `VARCHAR(50)`, dostepnosc `ENUM`, marka `VARCHAR(255)`, model `VARCHAR(255)`, rok_produkcji `YEAR`, przebieg `INT`, koszt `DECIMAL`, siedzenia `INT`

5. **pracownicy**
   - Pola: id `INT`, placowka_id `INT`, imie `VARCHAR(255)`, nazwisko `VARCHAR(255)`, data_urodzenia `DATE`, ulica `VARCHAR(255)`, miasto `VARCHAR(255)`, kod_pocztowy `VARCHAR(5)`, zarobki `INT`, pozycja `ENUM`

6. **rezerwacje**
   - Pola: id `INT`, klient_id `INT`, pojazd_id `INT`, lokacja_odbioru `INT`, lokacja_zwrotu `INT`, data_odbioru `DATE`, data_zwrotu `DATE` 

7. **ubezpieczenia**
    - Pola: id `INT`, imie `VARCHAR(255)`, polisa `VARCHAR(255)`, koszt `DECIMAL`

8. **wypozyczenia**
    - Pola: id `INT`, pracownik_id `INT`, placowka_id `INT`, rezerwacja_id `INT`

### Widoki
1. **ilosc_samochodow_po_dostepnosci**
   - Pola: dostepnosc `ENUM`, amount `BIGINT`
   - Opis: Liczba samochodów w zależności od dostępności.

2. **ilosc_samochodow_po_typie**
   - Pola: typ `ENUM`, amount `BIGINT`
   - Opis: Liczba samochodów w zależności od typu.

3. **piec_najaktywniejszych_klientow**
   - Pola: id `INT`, imie `VARCHAR(255)`, nazwisko `VARCHAR(255)`, numer_telefonu `VARCHAR(15)`, ulica `VARCHAR(255)`, miasto `VARCHAR(255)`, kod_pocztowy `VARCHAR(5)`, prawo_jazdy `VARCHAR(255)`, reservation_amount `BIGINT`
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

### Relacje
1. Tabela `klienci`
   - **Klucz główny:** `id`

2. Tabela `placowki`
   - **Klucz główny:** `id`

3. Tabela `platnosci`
   - **Klucz główny:** `id`
   - **Klucz obcy:** `rezerwacja_id` odnosi się do `rezerwacje.id`

4. Tabela `pojazdy`
   - **Klucz główny:** `id`
   - **Klucze obce:**
     - `placowka_id` odnosi się do `placowki.id`
     - `ubezpieczenie_id` odnosi się do `ubezpieczenia.id`
 
5. Tabela `pracownicy`
   - **Klucz główny:** `id`
   - **Klucz obcy:** `placowka_id` odnosi się do `placowki.id`
 
6. Tabela `rezerwacje`
   - **Klucz główny:** `id`
   - **Klucze obce:**
     - `klient_id` odnosi się do `klienci.id`
     - `pojazd_id` odnosi się do `pojazdy.id`
     - `lokacja_odbioru` odnosi się do `placowki.id`
     - `lokacja_zwrotu` odnosi się do `placowki.id`
 
7. Tabela `ubezpieczenia`
   - **Klucz główny:** `id`
 
8. Tabela `wypozyczenia`
   - **Klucz główny:** `id`
   - **Klucze obce:**
     - `pracownik_id` odnosi się do `pracownicy.id`
     - `placowka_id` odnosi się do `placowki.id`
     - `rezerwacja_id` odnosi się do `rezerwacje.id`

### Podsumowanie
Ta dokumentacja zawiera kompleksowy opis bazy danych "wypożyczalnia samochodów", obejmujący procedury, tabele i widoki wraz z ich strukturami i opisami.
