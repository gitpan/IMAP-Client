use Test::More tests => 59;

use IMAP::Client;
my $client = IMAP::Client->new;
my @resp;

my @lsub_response_cyrus = ('* LIST (\HasChildren) "." "user.johndoe"'."\r\n",
'* LIST (\HasChildren) "." "user.johndoe.spam"'."\r\n",
'* LIST (\HasNoChildren) "." "user.johndoe.spam.total garbage"'."\r\n",
'* LIST (\HasNoChildren) "." "user.johndoe.spam.phishing"'."\r\n",
'* LIST (\HasChildren) "." "user.johndoe.home"'."\r\n",
'* LIST (\HasNoChildren) "." "user.johndoe.home.mom"'."\r\n",
'* LIST (\HasNoChildren) "." "user.johndoe.home.grandparents"'."\r\n",
'1234 OK Completed (0.000 secs 7 calls)'."\r\n");

@resp = IMAP::Client::parse_list_lsub(@lsub_response_cyrus);
is (scalar @resp, 7);
is ($resp[0]->{'FLAGS'}, '\HasChildren');
is ($resp[0]->{'REFERENCE'}, '.');
is ($resp[0]->{'MAILBOX'}, 'user.johndoe');
is ($resp[1]->{'FLAGS'}, '\HasChildren');
is ($resp[1]->{'REFERENCE'}, '.');
is ($resp[1]->{'MAILBOX'}, 'user.johndoe.spam');
is ($resp[2]->{'FLAGS'}, '\HasNoChildren');
is ($resp[2]->{'REFERENCE'}, '.');
is ($resp[2]->{'MAILBOX'}, 'user.johndoe.spam.total garbage');
is ($resp[3]->{'FLAGS'}, '\HasNoChildren');
is ($resp[3]->{'REFERENCE'}, '.');
is ($resp[3]->{'MAILBOX'}, 'user.johndoe.spam.phishing');
is ($resp[4]->{'FLAGS'}, '\HasChildren');
is ($resp[4]->{'REFERENCE'}, '.');
is ($resp[4]->{'MAILBOX'}, 'user.johndoe.home');
is ($resp[5]->{'FLAGS'}, '\HasNoChildren');
is ($resp[5]->{'REFERENCE'}, '.');
is ($resp[5]->{'MAILBOX'}, 'user.johndoe.home.mom');
is ($resp[6]->{'FLAGS'}, '\HasNoChildren');
is ($resp[6]->{'REFERENCE'}, '.');
is ($resp[6]->{'MAILBOX'}, 'user.johndoe.home.grandparents');


my @lsub_response_iplanet = ('* LIST (\NoInferiors) "/" INBOX'."\r\n",
'* LIST (\HasNoChildren) "/" Deleted'."\r\n",
'* LIST (\HasNoChildren) "/" "Deleted Messages"'."\r\n",
'* LIST (\HasNoChildren) "/" Drafts'."\r\n",
'* LIST (\HasNoChildren) "/" Junk'."\r\n",
'* LIST (\HasNoChildren) "/" "Junk E-mail"'."\r\n",
'* LIST (\HasNoChildren) "/" Sent'."\r\n",
'* LIST (\HasNoChildren) "/" "Sent Items"'."\r\n",
'* LIST (\HasNoChildren) "/" Sent-aug-2005'."\r\n",
'* LIST (\HasNoChildren) "/" Test'."\r\n",
'* LIST (\HasNoChildren) "/" Test.txt'."\r\n",
'* LIST (\HasNoChildren) "/" Trash'."\r\n",
'A1 OK Completed'."\r\n");

@resp = IMAP::Client::parse_list_lsub(@lsub_response_iplanet);
is (scalar @resp, 12);
is ($resp[0]->{'FLAGS'}, '\NoInferiors');
is ($resp[0]->{'REFERENCE'}, '/');
is ($resp[0]->{'MAILBOX'}, 'INBOX');
is ($resp[1]->{'FLAGS'}, '\HasNoChildren');
is ($resp[1]->{'REFERENCE'}, '/');
is ($resp[1]->{'MAILBOX'}, 'Deleted');
is ($resp[2]->{'FLAGS'}, '\HasNoChildren');
is ($resp[2]->{'REFERENCE'}, '/');
is ($resp[2]->{'MAILBOX'}, 'Deleted Messages');
is ($resp[3]->{'FLAGS'}, '\HasNoChildren');
is ($resp[3]->{'REFERENCE'}, '/');
is ($resp[3]->{'MAILBOX'}, 'Drafts');
is ($resp[4]->{'FLAGS'}, '\HasNoChildren');
is ($resp[4]->{'REFERENCE'}, '/');
is ($resp[4]->{'MAILBOX'}, 'Junk');
is ($resp[5]->{'FLAGS'}, '\HasNoChildren');
is ($resp[5]->{'REFERENCE'}, '/');
is ($resp[5]->{'MAILBOX'}, 'Junk E-mail');
is ($resp[6]->{'FLAGS'}, '\HasNoChildren');
is ($resp[6]->{'REFERENCE'}, '/');
is ($resp[6]->{'MAILBOX'}, 'Sent');
is ($resp[7]->{'FLAGS'}, '\HasNoChildren');
is ($resp[7]->{'REFERENCE'}, '/');
is ($resp[7]->{'MAILBOX'}, 'Sent Items');
is ($resp[8]->{'FLAGS'}, '\HasNoChildren');
is ($resp[8]->{'REFERENCE'}, '/');
is ($resp[8]->{'MAILBOX'}, 'Sent-aug-2005');
is ($resp[9]->{'FLAGS'}, '\HasNoChildren');
is ($resp[9]->{'REFERENCE'}, '/');
is ($resp[9]->{'MAILBOX'}, 'Test');
is ($resp[10]->{'FLAGS'}, '\HasNoChildren');
is ($resp[10]->{'REFERENCE'}, '/');
is ($resp[10]->{'MAILBOX'}, 'Test.txt');
is ($resp[11]->{'FLAGS'}, '\HasNoChildren');
is ($resp[11]->{'REFERENCE'}, '/');
is ($resp[11]->{'MAILBOX'}, 'Trash');
