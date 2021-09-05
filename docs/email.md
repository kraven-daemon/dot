## mail related stuff

Mail server, using smtp protocol
also known as MTA : Mail transfer agent
    - When you have multiple email address you want to merge
    - When you just want to admin you own email server
    - When you want to send email
worth noticing
    all major smtp server also provide sendmail/delivery functionality

Mail agents, transport emails
also know as MDA : Mail delivery agent
    - When you want to retrieve email from a server
    - When you want to , optionnally, filter emails

Mail readers, or email client
also know as MUA : Mail user agent
    - When you want to parse/read email as text/html
    - When you you want to admin mailboxes

NOTABLE UTILS -> mblaze
    Contains a lot of cli-function to scan,filter address, etc, given a Maildir directory structure

Format -> probably Maildir _> a specification
    Maildir/{cur,new,tmp}
    not sure about Maildir++
    like dir.subdir

Minimalist suggestion

Exim _> Smtp server with `with extensive facilities for checking incoming e-mail.`
    meaning
GNU Mailman : a email list management utility design to be used with a smtp server

Neomutt _> ncurse email client pretty cool

fetchmail _> retrieve email and store them


Recommended -> implicit TLS -> avoid maninthemiddle attack
Ports
Purpose                        Port     Protocol        Encryption
Accept mail from other MTAs.    25      SMTP            STARTTLS
Accept submissions from MUAs.   587     SMTP            STARTTLS
                                465     SMTPS           implicit TLS
Let MUAs access mail.           110     POP3            STARTTLS
                                995     POP3S           implicit TLS
                                143     IMAP            STARTTLS
                                993     IMAPS           implicit TLS



