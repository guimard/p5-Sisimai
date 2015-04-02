package Sisimai::Reason::NoSpam;
use feature ':5.10';
use strict;
use warnings;

sub text  { 'nospam' }
sub match {
    # Rejected due to spam content in the message
    my $class = shift;
    my $argvs = shift // return undef;
    my $regex = qr{(?>
         ["]The[ ]mail[ ]server[ ]detected[ ]your[ ]message[ ]as[ ]spam[ ]and[ ]
            has[ ]prevented[ ]delivery[.]["]    # CPanel/Exim with SA rejections on
        |blocked[ ]by[ ](?:
             policy:[ ]no[ ]spam[ ]please
            |spamAssassin                   # rejected by SpamAssassin
            )
        |cyberoam[ ]anti[ ]spam[ ]engine[ ]has[ ]identified[ ]this[ ]email[ ]as[ ]a[ ]bulk[ ]email
        |denied[ ]due[ ]to[ ]spam[ ]list
        |dt:spm[ ]mx.+[ ]http://mail[.]163[.]com/help/help_spam_16[.]htm
        |mail[ ](?:
             appears[ ]to[ ]be[ ]unsolicited    # rejected due to spam
            |content[ ]denied   # http://service.mail.qq.com/cgi-bin/help?subtype=1&&id=20022&&no=1000726
            )
        |message[ ](?:
             filtered
            |filtered[.][ ]please[ ]see[ ]the[ ]faqs[ ]section[ ]on[ ]spam
            |rejected[ ]due[ ]to[ ]suspected[ ]spam[ ]content
            |refused[ ]by[ ]mailmarshal[ ]spamprofiler
            )
        |our[ ]filters[ ]rate[ ]at[ ]and[ ]above[ ].+[ ]percent[ ]probability[ ]of[ ]being[ ]spam
        |probable[ ]spam
        |rejected(?:
             :[ ]spamassassin[ ]score[ ]
            |[ ]due[ ]to[ ]spam[ ]content
            )
        |rejecting[ ]banned[ ]content 
        |spam[ ](?:
             detected
            |email[ ]not[ ]accepted
            |message[ ]rejected[.]       # mail.ru
            |not[ ]accepted
            |score[ ]
            )
        |spambouncer[ ]identified[ ]spam # SpamBouncer identified SPAM
        |transaction[ ]failed[ ]spam[ ]message[ ]not[ ]queued
        |we[ ]dont[ ]accept[ ]spam
        |your[ ](?:
             email[ ](?:
                 had[ ]spam[-]like[ ]
                |is[ ]considered[ ]spam
                |was[ ]detected[ ]as[ ]spam
                )
            |message[ ]has[ ]been[ ]temporarily[ ]blocked[ ]by[ ]our[ ]filter
            )
        )
    }xi;

    return 1 if $argvs =~ $regex;
    return 0;
}

sub true {
    # @Description  Rejected due to spam content in the message
    # @Param <obj>  (Sisimai::Data) Object
    # @Return       (Integer) 1 = rejected
    #               (Integer) 0 = is not rejected due to spam
    # @See          http://www.ietf.org/rfc/rfc2822.txt
    my $class = shift;
    my $argvs = shift // return undef;

    return undef unless ref $argvs eq 'Sisimai::Data';
    my $statuscode = $argvs->deliverystatus // '';
    my $reasontext = __PACKAGE__->text;

    return undef unless length $statuscode;
    return 1 if $argvs->reason eq $reasontext;

    require Sisimai::RFC3463;
    my $diagnostic = $argvs->diagnosticcode // '';
    my $v = 0;

    if( Sisimai::RFC3463->reason( $statuscode ) eq $reasontext ) {
        # Delivery status code points C<rejected>.
        $v = 1;

    } else {
        # Matched with a pattern in this class
        $v = 1 if __PACKAGE__->match( $diagnostic );
    }

    return $v;
}

1;
__END__

=encoding utf-8

=head1 NAME

Sisimai::Reason::NoSpam - Bounce reason is C<rejected> due to spam content in 
the message or not.

=head1 SYNOPSIS

    use Sisimai::Reason::NoSpam;
    print Sisimai::Reason::NoSpam->match('550 spam detected');   # 1

=head1 DESCRIPTION

Sisimai::Reason::NoSpam checks the bounce reason is C<rejected> due to spam 
content in the message or not. This class is called only Sisimai::Reason class.

=head1 CLASS METHODS

=head2 C<B<text()>>

C<text()> returns string: C<nospam>.

    print Sisimai::Reason::NoSpam->text;  # nospam

=head2 C<B<match( I<string> )>>

C<match()> returns 1 if the argument matched with patterns defined in this class.

    print Sisimai::Reason::NoSpam->match('550 Spam detected');   # 1

=head2 C<B<true( I<Sisimai::Data> )>>

C<true()> returns 1 if the bounce reason is C<rejected> due to spam content in 
the message. The argument must be Sisimai::Data object and this method is called
only from Sisimai::Reason class.

=head1 AUTHOR

azumakuniyuki

=head1 COPYRIGHT

Copyright (C) 2015 azumakuniyuki E<lt>perl.org@azumakuniyuki.orgE<gt>,
All Rights Reserved.

=head1 LICENSE

This software is distributed under The BSD 2-Clause License.

=cut
