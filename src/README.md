task 1:
    - extrag in edx id-ul furnicii (primii 8 biti) prin shifare pe 24 de biti la dreapta.
    - in edi am valoarea returnata de functie (initial 0).
    - extrag in ecx permisiunile furnicii.
    - shiftez eax la stanga cu 8 biti pentru a elimia bitii dorespondenti id-ului.
    - shiftez permisiunile pentru ca indicele salilor dorite sa coincida.
    - compar permisiunile.
    - verific daca comparatia coincide cu salile dorite.
    in caz afirmativ incrementez edi.
    - pun la adresa de return valoarea lui edi.

task 2:
    - am declarat o structura pentru a putea calcula automat lungimea unui element din structura.
    - scad ecx pentru a il folosi ca contor la primul loop.
    - urmatoarele 4 instructiuni pun in ecx lungimea sirului * lungimea unui element (cati bytes are).
    - astfel loop-ul se face decrementand cu lungimea elementului de structura la fiecare iteratie

subtask1
    - primul loop este practic un for dupa i de la n-1 la 1 (dupa ecx).
    al doilea este un for dupa j de la i-1 la 0 (dupa edi).

    primul criteriu de comparatie:
    - salvez pe stiva indicii ecx si edi (practic i si j).
    - in eax pun valoarea pentru admin de la idexul i, iar in edx de la j.
    - salvez edx pe stiva pentru a nu pierde valoarea la comparatie.
    - daca adminii sunt egali trec la urmatorul criteriu de comparatie.
    - altfel extrag valoarea initiala a edx din stiva si verific daca edx (val de la j) este mai mic decat eax (val de la i).
    in caz afirmativ interschimv tot elem de structura, altfel sunt bine puse si trec la urmatorul element.

    al doilea criteriu:
    - similar cu primul criteriu.
    - diferenta este ca acum interschimb daca diferenta este mai mare ca 0.

    al treilea criteriu:
    - incepe la fel, dar comparatia se face de aceasta data byte cu byte:
    daca sunt egali trec la urmatorul, incrementand ecx (i) si edx (j), altfel le scad si daca rezultatul este pozitiv interschimb.
    
    interschimbarea:
    - presupune parcurgerea si interschimbarea byte cu byte la ambele elemente de structura.
    - la inceput extrag valorile initiale ecx si edi (ca e posibil sa se fi schimbat in cadrul criteriului 3).
    - esi contine indicele la care am ajuns in parcurgerea block-ului.
    - in final scad din edi si ecx lungimea elementului de structura deoarece prin interschimbare am trecut practic la urmatorul i si j.

    - la final de functie am actualizarea inficilor celor doua loop-uri.

subtask2:
    - edi este indicele de parcurgere al passkey. i = n-1 la 0
    - initial fac elementul curent din vector 0.
    - in edx salvez passkey-ul curent.
    - verific daca ultimul bit este 1, in caz negativ trec direct la urmatorul element.
    - verific daca primul bit este 1 si continui verificarile numai daca este.
    - rotesc la dreapta cu 1 pentru a elimina ultimul bit (deja verificat).
    - esi este contor pentru iteratia in fiecare byte din passkey, iar edi este un contor care numara cati de 1 sunt in block-ul curent.
    - prima data parcurg numai 7 biti (cei mai semnificativi):
    pt fiecare iteratie verific daca ultimul bit este 1, in caz afirmariv incrementez contorul.
    apoi reotesc la dreapta cu 1.
    la final verific daca este par edi si in caz contrar trec la urmatorul passkey.
    - similar cu pasul anterior: parcurg cei 7 mai putin semnificativi biti.
    in final, daca edi este impar, pun la pozitia curenta 1 in vectorul de return.

task 3:
encrypt
    - salvez numarul de runde in edx (contor pentru prima bucla, cea de runde).
    - fac ecx 0 (contor pentru cei 8 bytes) si il pun in stiva.
    - extrag ecx din stiva.
    - zeriozez eax (deoarece am nevoie numai de al, iar restul bitilor vreau sa fie 0).
    - efectuez operatiile de copiere a byte-ului din text, adunare a byte-ului din cheie si inlocuire cu corespondent din sbox.
    - adaug la stiva ecx (prin comaparea cu xor se pierde valoarea).
    - verific daca am ajuns la ultimul bit din block
    in caz afirmativ, fac operatiile aferente acestui caz (similare cu cele de caz contrar, doar ca op se efectueaza cu primul byte).
    altfel, extrag valoarea lui ecx din stiva, adaug la eax byte-ul urmator din text, rotesc la stanga bitii si mut rezultatul in pozitia urmatoare din text.
    - dupa aceste operatii, cresc ecx si verific daca am ajuns la finalul block-ului.
    in caz afirmativ, decrementez edx si trec la urmatoarea runda, altfel continui in block.

decrypt:
    - similar cu encrypt.
    - in ecx salvez acum nr maxim de bytes (deoarece de aceasta data folosesc loop).
    - pentru ca loop sa functioneze corect in ecx salvez 8.
    astfel pentru a calcula corect byte-ul curent este necesar sa efectuez calculele cu 1 in minus.
    - dupa subsitutia cu valoarea din sbox, in eax ramane salvat top.
    - calculez in ebx bottom: salvez valoarea de la byte-ul urmator, o rotesc la dreapta cu 1.
    - scad din eax ebx si salvez rezultatul la adresa byte-ului urmator.

task 4:
    - decrementez ecx si edx pentru a putea efectua cu mai mare usurinta oprirea din bucla.
    - fac valoarea de la (0,0) ca fiind 1 (am trecut deja prin zona respectiva).
    - salvez pe stiva adresele folosite la returnarea functiei pentru a nu le pierde pe parcurs si initializez eax si ebx cu 0 (linia 0, coloana 0).
    - in bucla salvez la fiecare pas pe stiva linia (deoarece eax va fi folosit mereu pentru calcularea valorii curente din matrice).

    verificarea de a merge in sus:
    - salvez in edi linia si verific daca sunt pe prima.
    in caz afirmativ, stiu ca nu pot inainta acolo si trec la verificarea altor directii.
    - zeriozez eax (iar retin numai ultimul byte - un char) si decrementez edi (linia).
    - salvez in edi pointer-ul la linia anterioara, apoi folosindu-ma de acesta, salvez in al valoarea de la linia anterioara, coloana curenta.
    - verific daca valoarea din eax este 0.
    in caz afirmativ, extrag din stiva linia curenta si o decrementez, dupa care avansez la verificarea daca am ajuns la iesire.
    altfel am dat de obstacol si trec la verificarea altor directii.

    verificare jos:
    - similar sus.
    - nu mai este necesara verificarea iesirii din matrice (daca ar fi sa iasa in jos inseamna ca am ajuns deja la iesire).
    - in loc sa decrementez linia, o incrementez.

    verificare stanga:
    - relativ similar sus.
    - de aceasta data salvez in stiva atat linia cat si coloana (aceasta se poate modifica in cadrul verificarii, dar nu mereu ajuta acest lucru).
    - verific iesirea din matrice (acum la coloana, pt cazul in care ma aflu pe prima).
    
    verificare stanga:
    - daca am ajuns aici inseamna ca este singura directie in care se poate inainta si asadar incrementez coloana.

    verificare iesire:
    - verific daca eax a atins numarul maxim de linii.
    in caz afirmativ sar la partea de returnare a valorilor.
    - altfel verific daca ebx a ajuns la numarul de coloane.
    - in caz negativ, mai am de avansat in matrice si marchez celula curenta ca fiind vizitata (o fac 1).

    returnarea val:
    - extrag din stiva valorile liniei si coloanei iesirii.
    - extrag adresele liniei si coloanei.
    - copiez valorile la adresele corespondente.