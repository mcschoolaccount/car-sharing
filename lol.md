## Dokumentacja dla Bazy Danych "b"

### Przegląd
- **Silnik Bazy Danych:** InnoDB
- **Wersja PHPMyAdmin:** 5.2.0
- **Wersja MariaDB:** 10.4.24
- **Wersja PHP:** 8.1.6

### Procedury
1. **departamenty_po_kodzie_pocztowym**
   - Parametry: `kod_pocztowy` (VARCHAR(5))
   - Opis: Pobierz departamenty na podstawie kodu pocztowego.

2. **dostepne_samochody_w_przedziale_cenowym**
   - Parametry: `min_value` (INT), `max_value` (INT)
   - Opis: Pobierz dostępne samochody w określonym przedziale cenowym.

3. **najczesciej_uzywane_auto**
   - Opis: Pobierz najczęściej używany samochód.

4. **pojazdy_po_vin**
   - Parametry: `vin` (VARCHAR(50))
   - Opis: Pobierz pojazdy na podstawie numeru identyfikacyjnego VIN.

5. **pojazdy_zarezerwowane_w_dniach**
   - Parametry: `data_odbioru` (DATE), `data_zwrotu` (DATE)
   - Opis: Pobierz zarezerwowane pojazdy w określonych datach.

6. **polisy_po_vin_pojazdu**
   - Parametry: `vin` (VARCHAR(50))
   - Opis: Pobierz polisy ubezpieczeniowe na podstawie numeru identyfikacyjnego VIN pojazdu.

7. **przychod_w_danym_roku_i_miesiacu**
   - Parametry: `p_year` (INT), `p_month` (ENUM)
   - Opis: Pobierz przychód dla określonego roku i miesiąca.

8. **samochody_wynajete_przez_pracownika**
   - Parametry: `imie` (VARCHAR(255)), `nazwisko` (VARCHAR(255))
   - Opis: Pobierz samochody wynajęte przez pracownika.

9. **samochody_wypozyczone_przez_klienta**
   - Parametry: `imie` (VARCHAR(255)), `nazwisko` (VARCHAR(255)), `numer_telefonu` (INT(15))
   - Opis: Pobierz samochody wypożyczone przez klienta.

10. **samochody_w_departamencie**
    - Parametry: `dep_id` (INT)
    - Opis: Pobierz samochody w określonym departamencie.

### Tabele
1. **klienci**
   - Pola: id, imie, nazwisko, numer_telefonu, ulica, miasto, kod_pocztowy, prawo_jazdy

2. **ilosc_samochodow_po_dostepnosci** (Widok)
   - Pola: dostepnosc, amount

3. **ilosc_samochodow_po_typie** (Widok)
   - Pola: typ, amount

4. **piec_najaktywniejszych_klientow** (Widok)
   - Pola: id, imie, nazwisko, numer_telefonu, ulica, miasto, kod_pocztowy, prawo_jazdy, reservation_amount

5. **placowki**
   - Pola: id, imie, ulica, miasto, wojewodztwo, kraj, kod_pocztowy

6. **platnosci**
   - Pola: id, data, kwota, rezerwacja_id

7. **pojazdy**
   - Pola: id, typ, placowka_id, ubezpieczenie_id, vin, dostepnosc, marka, model, rok_produkcji, przebieg, koszt, siedzenia

8. **pracownicy**
   - Pola: id, placowka_id, imie, nazwisko, data_urodzenia, ulica, miasto, kod_pocztowy, zarobki, pozycja

9. **rezerwacje**
   - Pola: id, klient_id, pojazd_id, lokacja_odbioru, lokacja_zwrotu, data_odbioru, data_zwrotu

10. **ubezpieczenia**
    - Pola: id, imie, polisa, koszt

11. **wypozyczenia**
    - Pola: id, pracownik_id, placowka_id, rezerwacja_id

### Widoki
1. **ilosc_samochodow_po_dostepnosci**
   - Opis: Liczba samochodów w zależności od dostępności.

2. **ilosc_samochodow_po_typie**
   - Opis: Liczba samochodów w zależności od typu.

3. **piec_najaktywniejszych_klientow**
   - Opis: Pięciu najaktywniejszych klientów.

### Podsumowanie
Ta dokumentacja zawiera kompleksowy opis bazy danych "b", obejmujący procedury, tabele i widoki wraz z ich strukturami i opisami.
