<h1> ADISE20_AEX | Τάβλι-Πλακωτό </h1>

Table of Contents
=================
   * [Εγκατάσταση](#εγκατάσταση)
      * [Απαιτήσεις](#απαιτήσεις)
      * [Οδηγίες Εγκατάστασης](#οδηγίες-εγκατάστασης)
   * [Περιγραφή API](#περιγραφή-api)
      * [Methods](#methods)
         * [Board](#board)
            * [Ανάγνωση Board](#ανάγνωση-board)
            * [Αρχικοποίηση Board](#αρχικοποίηση-board)
         * [Piece](#piece)
            * [Ανάγνωση Θέσης/Πιονιού](#ανάγνωση-θέσηςπιονιού)
            * [Μεταβολή Θέσης Πιονιού](#μεταβολή-θέσης-πιονιού)
         * [Player](#player)
            * [Ανάγνωση στοιχείων παίκτη](#ανάγνωση-στοιχείων-παίκτη)
            * [Καθορισμός στοιχείων παίκτη](#καθορισμός-στοιχείων-παίκτη)
         * [Status](#status)
            * [Ανάγνωση κατάστασης παιχνιδιού](#ανάγνωση-κατάστασης-παιχνιδιού)
      * [Entities](#entities)
         * [Board](#board-1)
         * [Players](#players)
         * [Game_status](#game_status)


# Εγκατάσταση

## Απαιτήσεις

* Apache2
* Mysql Server
* php


## Οδηγίες Εγκατάστασης

 * Κάντε clone το project σε κάποιον φάκελο <br/>
  `$ https://github.com/iee-ihu-gr-course1941/ADISE20_AEX/index.php	

 * Βεβαιωθείτε ότι ο φάκελος είναι προσβάσιμος από τον Apache Server. πιθανόν να χρειαστεί να καθορίσετε τις παρακάτω ρυθμίσεις.

 * Θα πρέπει να δημιουργήσετε στην Mysql την βάση με όνομα 'adise19_chess5' και να φορτώσετε σε αυτήν την βάση τα δεδομένα από το αρχείο DB/schema5.sql

 * Θα πρέπει να φτιάξετε το αρχείο lib/config_local.php το οποίο να περιέχει:
```
    <?php
	$DB_PASS = 'κωδικός';
	$DB_USER = 'όνομα χρήστη';
    ?>
```




# Περιγραφή Παιχνιδιού

# Στήσιμο #

 

Ο κάθε παίκτης έχει την περιοχή εκκίνησής του μπροστά του (κάτω δεξιά ή κάτω αριστερά) και απέναντί της βρίσκεται η περιοχή μαζέματος. Κινείται κανονικά από την περιοχή εκκίνησης στην περιοχή μαζέματος κυκλικά. Η περιοχή εκκίνησης του ενός παίκτη είναι η περιοχή μαζέματος του άλλου. 

Στην αρχική θέση και τα δεκαπέντε πούλια του παίχτη τοποθετούνται στην θέση α δηλαδή την πρώτη θέση της κίνησής τους (λέγεται μάνα, η β λέγεται παραμάνα και η γ προπαραμάνα). 

 
#Πλάκωμα #

 

Όταν ένα πούλι βρίσκεται μόνο του σε μια θέση (δεν αποτελεί πόρτα) ο αντίπαλος έχει το δικαίωμα να κινήσει σε αυτήν την θέση πούλι του πλακώνοντας το εχθρικό πούλι. Η θέση γίνεται πόρτα του παίκτη που πλακώνει και ο οποίος έχει την δυνατότητα να τοποθετεί όσα πούλια ακόμα θέλει σε αυτήν. 

 Το πλακωμένο πούλι δεν έχει το δικαίωμα να κινηθεί από την θέση του. Τα πούλια που το πλακώνουν είναι ελεύθερα να κινηθούν από την θέση αυτή αν όμως φύγουν όλα από τη θέση τότε το πούλι ξεπλακώνεται και είναι ελεύθερο να κινηθεί κανονικά. 

Ο παίκτης έχει το δικαίωμα να ξεκινήσει το μάζεμα όταν όλα τα πούλια του βρίσκονται στην περιοχή μαζέματος και ο αντίπαλος του δεν έχει κανένα πλακωμένο πούλι του παίκτη . Αν κατά τη διάρκεια του μαζέματος από τον παίκτη, ο αντίπαλος πλακώσει κάποιο πούλι ή πούλια του παίκτη, τότε ο παίκτης σταματάει το μάζεμα μέχρι να ξεπλακώσει ο αντίπαλος τα πούλια του παίκτη. 

Στο πλακωτό όπως και στις πόρτες και το φεύγα είναι υποχρεωτική η ολοκλήρωση μιας ζαριάς. 

#Πιάσιμο της μάνας #


## Συντελεστές

Προγραμματιστής 1: it144177, Αλέξανδρος Γουργιώτης

Προγραμματιστής 2: 


# Περιγραφή API

## Methods


### Board
#### Ανάγνωση Board

```
GET /board/
```

Επιστρέφει το [Board](#Board).

#### Αρχικοποίηση Board
```
POST /board/
```

Αρχικοποιεί το Board, δηλαδή το παιχνίδι. Γίνονται reset τα πάντα σε σχέση με το παιχνίδι.
Επιστρέφει το [Board](#Board).

### Piece
#### Ανάγνωση Θέσης/Πιονιού

```
GET /board/piece/:x/:y/
```

Κάνει την κίνηση του πιονιού από την θέση x,y στην νέα θέση. Προφανώς ελέγχεται η κίνηση αν είναι νόμιμη καθώς και αν είναι η σειρά του παίκτη να παίξει με βάση το token.
Επιστρέφει τα στοιχεία από το [Board](#Board-1) με συντεταγμένες x,y.
Περιλαμβάνει το χρώμα του πιονιού και τον τύπο.

#### Μεταβολή Θέσης Πιονιού

```
PUT /board/piece/:x/:y/
```
Json Data:

| Field             | Description                 | Required   |
| ----------------- | --------------------------- | ---------- |
| `x`               | Η νέα θέση x                | yes        |
| `y`               | Η νέα θέση y                | yes        |

Επιστρέφει τα στοιχεία από το [Board](#Board-1) με συντεταγμένες x,y.
Περιλαμβάνει το χρώμα του πιονιού και τον τύπο


### Player

#### Ανάγνωση στοιχείων παίκτη
```
GET /players/:p
```

Επιστρέφει τα στοιχεία του παίκτη p ή όλων των παικτών αν παραληφθεί. Το p μπορεί να είναι 'B' ή 'W'.

#### Καθορισμός στοιχείων παίκτη
```
PUT /players/:p
```
Json Data:

| Field             | Description                 | Required   |
| ----------------- | --------------------------- | ---------- |
| `username`        | Το username για τον παίκτη p. | yes        |
| `color`           | To χρώμα που επέλεξε ο παίκτης p. | yes        |


Επιστρέφει τα στοιχεία του παίκτη p και ένα token. Το token πρέπει να το χρησιμοποιεί ο παίκτης καθόλη τη διάρκεια του παιχνιδιού.

### Status

#### Ανάγνωση κατάστασης παιχνιδιού
```
GET /status/
```

Επιστρέφει το στοιχείο [Game_status](#Game_status).



## Entities


### Board
---------

Το board είναι ένας πίνακας, ο οποίος στο κάθε στοιχείο έχει τα παρακάτω:


| Attribute                | Description                                  | Values                              |
| ------------------------ | -------------------------------------------- | ----------------------------------- |
| `x`                      | H συντεταγμένη x του τετραγώνου              | 1..24                                |
| `y`                      | H συντεταγμένη y του τετραγώνου              | 1..15                                |
| `b_color`                | To χρώμα του τετραγώνου                      | 'B','W'                             |
| `piece_color`            | To χρώμα του πιονιού                         | 'B','W', null                       |
| `piece`                  | To Πιόνι που υπάρχει στο τετράγωνο           | Το id του πιονιού       |



### Players
---------

O κάθε παίκτης έχει τα παρακάτω στοιχεία:


| Attribute                | Description                                  | Values                              |
| ------------------------ | -------------------------------------------- | ----------------------------------- |
| `username`               | Όνομα παίκτη                                 | String                              |
| `piece_color`            | To χρώμα που παίζει ο παίκτης                | 'B','W'                             |
| `token  `                | To κρυφό token του παίκτη. Επιστρέφεται μόνο τη στιγμή της εισόδου του παίκτη στο παιχνίδι | HEX |
| `last_action`            | Τελευταία αλλαγή/ενέργεια στην κατάσταση του παίχτη         | timestamp |

### Game_status
---------

H κατάσταση παιχνιδιού έχει τα παρακάτω στοιχεία:


| Attribute                | Description                                  | Values                              |
| ------------------------ | -------------------------------------------- | ----------------------------------- |
| `status  `               | Κατάσταση             | 'not active', 'initialized', 'started', 'ended', 'aborded'     |
| `p_turn`                 | To χρώμα του παίκτη που παίζει        | 'B','W',null                              |
| `result`                 |  To χρώμα του παίκτη που κέρδισε |'B','W',null                              |
| `last_change`            | Τελευταία αλλαγή/ενέργεια στην κατάσταση του παιχνιδιού         | timestamp |