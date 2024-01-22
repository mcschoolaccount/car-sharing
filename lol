## Documentation for Database "b"

### Overview
- **Database Engine:** InnoDB
- **PHPMyAdmin Version:** 5.2.0
- **MariaDB Version:** 10.4.24
- **PHP Version:** 8.1.6

### Procedures
1. **departamenty_po_kodzie_pocztowym**
   - Parameters: `kod_pocztowy` (VARCHAR(5))
   - Description: Retrieve departments based on postal code.

2. **dostepne_samochody_w_przedziale_cenowym**
   - Parameters: `min_value` (INT), `max_value` (INT)
   - Description: Retrieve available cars within a price range.

3. **najczesciej_uzywane_auto**
   - Description: Retrieve the most frequently used car.

4. **pojazdy_po_vin**
   - Parameters: `vin` (VARCHAR(50))
   - Description: Retrieve vehicles based on VIN.

5. **pojazdy_zarezerwowane_w_dniach**
   - Parameters: `data_odbioru` (DATE), `data_zwrotu` (DATE)
   - Description: Retrieve reserved vehicles within specified dates.

6. **polisy_po_vin_pojazdu**
   - Parameters: `vin` (VARCHAR(50))
   - Description: Retrieve insurance policies based on vehicle VIN.

7. **przychod_w_danym_roku_i_miesiacu**
   - Parameters: `p_year` (INT), `p_month` (ENUM)
   - Description: Retrieve income for a specific year and month.

8. **samochody_wynajete_przez_pracownika**
   - Parameters: `imie` (VARCHAR(255)), `nazwisko` (VARCHAR(255))
   - Description: Retrieve cars rented by an employee.

9. **samochody_wypozyczone_przez_klienta**
   - Parameters: `imie` (VARCHAR(255)), `nazwisko` (VARCHAR(255)), `numer_telefonu` (INT(15))
   - Description: Retrieve cars rented by a customer.

10. **samochody_w_departamencie**
    - Parameters: `dep_id` (INT)
    - Description: Retrieve cars in a specific department.

### Tables
1. **klienci**
   - Fields: id, imie, nazwisko, numer_telefonu, ulica, miasto, kod_pocztowy, prawo_jazdy

2. **ilosc_samochodow_po_dostepnosci** (View)
   - Fields: dostepnosc, amount

3. **ilosc_samochodow_po_typie** (View)
   - Fields: typ, amount

4. **piec_najaktywniejszych_klientow** (View)
   - Fields: id, imie, nazwisko, numer_telefonu, ulica, miasto, kod_pocztowy, prawo_jazdy, reservation_amount

5. **placowki**
   - Fields: id, imie, ulica, miasto, wojewodztwo, kraj, kod_pocztowy

6. **platnosci**
   - Fields: id, data, kwota, rezerwacja_id

7. **pojazdy**
   - Fields: id, typ, placowka_id, ubezpieczenie_id, vin, dostepnosc, marka, model, rok_produkcji, przebieg, koszt, siedzenia

8. **pracownicy**
   - Fields: id, placowka_id, imie, nazwisko, data_urodzenia, ulica, miasto, kod_pocztowy, zarobki, pozycja

9. **rezerwacje**
   - Fields: id, klient_id, pojazd_id, lokacja_odbioru, lokacja_zwrotu, data_odbioru, data_zwrotu

10. **ubezpieczenia**
    - Fields: id, imie, polisa, koszt

11. **wypozyczenia**
    - Fields: id, pracownik_id, placowka_id, rezerwacja_id

### Views
1. **ilosc_samochodow_po_dostepnosci**
   - Description: Count of cars based on availability.

2. **ilosc_samochodow_po_typie**
   - Description: Count of cars based on type.

3. **piec_najaktywniejszych_klientow**
   - Description: Top five most active customers.

### Conclusion
This documentation provides a comprehensive overview of the "b" database, including procedures, tables, and views, along with their respective structures and descriptions.
