use strict;
use warnings;
use Test::More;
use lib qw(./lib ./blib/lib);
require './t/600-bite-email-code';

my $enginename = 'Sendmail';
my $samplepath = sprintf("./set-of-emails/private/email-%s", lc $enginename);
my $enginetest = Sisimai::Bite::Email::Code->maketest;
my $isexpected = [
    { 'n' => '01001', 'r' => qr/suspend/        },
    { 'n' => '01002', 'r' => qr/blocked/        },
    { 'n' => '01003', 'r' => qr/expired/        },
    { 'n' => '01004', 'r' => qr/(?:userunknown|delivered)/ },
    { 'n' => '01005', 'r' => qr/expired/        },
    { 'n' => '01006', 'r' => qr/expired/        },
    { 'n' => '01007', 'r' => qr/expired/        },
    { 'n' => '01008', 'r' => qr/filtered/       },
    { 'n' => '01009', 'r' => qr/expired/        },
    { 'n' => '01010', 'r' => qr/blocked/        },
    { 'n' => '01011', 'r' => qr/blocked/        },
    { 'n' => '01012', 'r' => qr/systemerror/    },
    { 'n' => '01013', 'r' => qr/userunknown/    },
    { 'n' => '01014', 'r' => qr/expired/        },
    { 'n' => '01015', 'r' => qr/hostunknown/    },
    { 'n' => '01016', 'r' => qr/expired/        },
    { 'n' => '01017', 'r' => qr/expired/        },
    { 'n' => '01018', 'r' => qr/hostunknown/    },
    { 'n' => '01019', 'r' => qr/blocked/        },
    { 'n' => '01020', 'r' => qr/expired/        },
    { 'n' => '01021', 'r' => qr/expired/        },
    { 'n' => '01022', 'r' => qr/expired/        },
    { 'n' => '01023', 'r' => qr/expired/        },
    { 'n' => '01024', 'r' => qr/filtered/       },
    { 'n' => '01025', 'r' => qr/mesgtoobig/     },
    { 'n' => '01026', 'r' => qr/blocked/        },
    { 'n' => '01027', 'r' => qr/rejected/       },
    { 'n' => '01028', 'r' => qr/norelaying/     },
    { 'n' => '01029', 'r' => qr/spamdetected/   },
    { 'n' => '01030', 'r' => qr/suspend/        },
    { 'n' => '01031', 'r' => qr/suspend/        },
    { 'n' => '01032', 'r' => qr/mailererror/    },
    { 'n' => '01033', 'r' => qr/mailererror/    },
    { 'n' => '01034', 'r' => qr/mailererror/    },
    { 'n' => '01035', 'r' => qr/userunknown/    },
    { 'n' => '01036', 'r' => qr/filtered/       },
    { 'n' => '01037', 'r' => qr/filtered/       },
    { 'n' => '01038', 'r' => qr/userunknown/    },
    { 'n' => '01039', 'r' => qr/(?:filtered|userunknown)/ },
    { 'n' => '01040', 'r' => qr/userunknown/    },
    { 'n' => '01041', 'r' => qr/filtered/       },
    { 'n' => '01042', 'r' => qr/userunknown/    },
    { 'n' => '01043', 'r' => qr/userunknown/    },
    { 'n' => '01044', 'r' => qr/userunknown/    },
    { 'n' => '01045', 'r' => qr/userunknown/    },
    { 'n' => '01046', 'r' => qr/userunknown/    },
    { 'n' => '01047', 'r' => qr/blocked/        },
    { 'n' => '01048', 'r' => qr/userunknown/    },
    { 'n' => '01049', 'r' => qr/userunknown/    },
    { 'n' => '01050', 'r' => qr/userunknown/    },
    { 'n' => '01051', 'r' => qr/userunknown/    },
    { 'n' => '01052', 'r' => qr/userunknown/    },
    { 'n' => '01053', 'r' => qr/userunknown/    },
    { 'n' => '01054', 'r' => qr/userunknown/    },
    { 'n' => '01055', 'r' => qr/userunknown/    },
    { 'n' => '01056', 'r' => qr/userunknown/    },
    { 'n' => '01057', 'r' => qr/userunknown/    },
    { 'n' => '01058', 'r' => qr/norelaying/     },
    { 'n' => '01059', 'r' => qr/userunknown/    },
    { 'n' => '01060', 'r' => qr/userunknown/    },
    { 'n' => '01061', 'r' => qr/blocked/        },
    { 'n' => '01062', 'r' => qr/userunknown/    },
    { 'n' => '01063', 'r' => qr/userunknown/    },
    { 'n' => '01064', 'r' => qr/userunknown/    },
    { 'n' => '01065', 'r' => qr/userunknown/    },
    { 'n' => '01066', 'r' => qr/userunknown/    },
    { 'n' => '01067', 'r' => qr/userunknown/    },
    { 'n' => '01068', 'r' => qr/userunknown/    },
    { 'n' => '01069', 'r' => qr/userunknown/    },
    { 'n' => '01070', 'r' => qr/userunknown/    },
    { 'n' => '01071', 'r' => qr/userunknown/    },
    { 'n' => '01072', 'r' => qr/userunknown/    },
    { 'n' => '01073', 'r' => qr/userunknown/    },
    { 'n' => '01074', 'r' => qr/userunknown/    },
    { 'n' => '01075', 'r' => qr/userunknown/    },
    { 'n' => '01076', 'r' => qr/userunknown/    },
    { 'n' => '01077', 'r' => qr/userunknown/    },
    { 'n' => '01078', 'r' => qr/userunknown/    },
    { 'n' => '01079', 'r' => qr/userunknown/    },
    { 'n' => '01080', 'r' => qr/userunknown/    },
    { 'n' => '01081', 'r' => qr/userunknown/    },
    { 'n' => '01082', 'r' => qr/userunknown/    },
    { 'n' => '01083', 'r' => qr/userunknown/    },
    { 'n' => '01084', 'r' => qr/filtered/       },
    { 'n' => '01085', 'r' => qr/filtered/       },
    { 'n' => '01086', 'r' => qr/hostunknown/    },
    { 'n' => '01087', 'r' => qr/hostunknown/    },
    { 'n' => '01088', 'r' => qr/hostunknown/    },
    { 'n' => '01089', 'r' => qr/norelaying/     },
    { 'n' => '01090', 'r' => qr/filtered/       },
    { 'n' => '01091', 'r' => qr/filtered/       },
    { 'n' => '01092', 'r' => qr/filtered/       },
    { 'n' => '01093', 'r' => qr/suspend/        },
    { 'n' => '01094', 'r' => qr/mailboxfull/    },
    { 'n' => '01095', 'r' => qr/mailboxfull/    },
    { 'n' => '01096', 'r' => qr/mailboxfull/    },
    { 'n' => '01097', 'r' => qr/mailboxfull/    },
    { 'n' => '01098', 'r' => qr/exceedlimit/    },
    { 'n' => '01099', 'r' => qr/exceedlimit/    },
    { 'n' => '01100', 'r' => qr/exceedlimit/    },
    { 'n' => '01101', 'r' => qr/systemerror/    },
    { 'n' => '01102', 'r' => qr/filtered/       },
    { 'n' => '01103', 'r' => qr/filtered/       },
    { 'n' => '01104', 'r' => qr/mesgtoobig/     },
    { 'n' => '01105', 'r' => qr/mesgtoobig/     },
    { 'n' => '01106', 'r' => qr/mesgtoobig/     },
    { 'n' => '01107', 'r' => qr/systemerror/    },
    { 'n' => '01108', 'r' => qr/systemerror/    },
    { 'n' => '01109', 'r' => qr/filtered/       },
    { 'n' => '01110', 'r' => qr/filtered/       },
    { 'n' => '01111', 'r' => qr/networkerror/   },
    { 'n' => '01112', 'r' => qr/mailererror/    },
    { 'n' => '01113', 'r' => qr/contenterror/   },
    { 'n' => '01114', 'r' => qr/policyviolation/},
    { 'n' => '01115', 'r' => qr/policyviolation/},
    { 'n' => '01116', 'r' => qr/spamdetected/   },
    { 'n' => '01117', 'r' => qr/spamdetected/   },
    { 'n' => '01118', 'r' => qr/userunknown/    },
    { 'n' => '01119', 'r' => qr/filtered/       },
    { 'n' => '01120', 'r' => qr/filtered/       },
    { 'n' => '01121', 'r' => qr/filtered/       },
    { 'n' => '01122', 'r' => qr/userunknown/    },
    { 'n' => '01124', 'r' => qr/expired/        },
    { 'n' => '01125', 'r' => qr/mesgtoobig/     },
    { 'n' => '01127', 'r' => qr/userunknown/    },
    { 'n' => '01128', 'r' => qr/(?:rejected|filtered|userunknown|hostunknown|blocked)/ },
    { 'n' => '01129', 'r' => qr/hasmoved/       },
    { 'n' => '01130', 'r' => qr/userunknown/    },
    { 'n' => '01131', 'r' => qr/filtered/       },
    { 'n' => '01132', 'r' => qr/filtered/       },
    { 'n' => '01133', 'r' => qr/filtered/       },
    { 'n' => '01134', 'r' => qr/mesgtoobig/     },
    { 'n' => '01135', 'r' => qr/userunknown/    },
    { 'n' => '01136', 'r' => qr/hostunknown/    },
    { 'n' => '01137', 'r' => qr/(?:userunknown|mailboxfull)/ },
    { 'n' => '01138', 'r' => qr/filtered/       },
    { 'n' => '01139', 'r' => qr/filtered/       },
    { 'n' => '01140', 'r' => qr/filtered/       },
    { 'n' => '01141', 'r' => qr/userunknown/    },
    { 'n' => '01142', 'r' => qr/policyviolation/},
    { 'n' => '01143', 'r' => qr/userunknown/    },
    { 'n' => '01144', 'r' => qr/userunknown/    },
    { 'n' => '01145', 'r' => qr/userunknown/    },
    { 'n' => '01146', 'r' => qr/userunknown/    },
    { 'n' => '01147', 'r' => qr/mesgtoobig/     },
    { 'n' => '01148', 'r' => qr/userunknown/    },
    { 'n' => '01149', 'r' => qr/userunknown/    },
    { 'n' => '01150', 'r' => qr/userunknown/    },
    { 'n' => '01151', 'r' => qr/mailboxfull/    },
    { 'n' => '01152', 'r' => qr/systemerror/    },
    { 'n' => '01153', 'r' => qr/mailererror/    },
    { 'n' => '01154', 'r' => qr/userunknown/    },
    { 'n' => '01155', 'r' => qr/mesgtoobig/     },
    { 'n' => '01156', 'r' => qr/userunknown/    },
    { 'n' => '01157', 'r' => qr/(?:hostunknown|filtered)/ },
    { 'n' => '01158', 'r' => qr/expired/        },
    { 'n' => '01159', 'r' => qr/mailboxfull/    },
    { 'n' => '01160', 'r' => qr/filtered/       },
    { 'n' => '01161', 'r' => qr/userunknown/    },
    { 'n' => '01162', 'r' => qr/(?:userunknown|filtered)/ },
    { 'n' => '01163', 'r' => qr/userunknown/    },
    { 'n' => '01164', 'r' => qr/rejected/       },
    { 'n' => '01165', 'r' => qr/exceedlimit/    },
    { 'n' => '01166', 'r' => qr/contenterror/   },
    { 'n' => '01167', 'r' => qr/norelaying/     },
    { 'n' => '01168', 'r' => qr/blocked/        },
    { 'n' => '01169', 'r' => qr/policyviolation/},
    { 'n' => '01170', 'r' => qr/blocked/        },
    { 'n' => '01171', 'r' => qr/expired/        },
    { 'n' => '01172', 'r' => qr/systemerror/    },
    { 'n' => '01173', 'r' => qr/userunknown/    },
    { 'n' => '01174', 'r' => qr/hostunknown/    },
    { 'n' => '01175', 'r' => qr/blocked/        },
    { 'n' => '01176', 'r' => qr/hasmoved/       },
    { 'n' => '01177', 'r' => qr/mailererror/    },
    { 'n' => '01178', 'r' => qr/hostunknown/    },
    { 'n' => '01179', 'r' => qr/userunknown/    },
    { 'n' => '01180', 'r' => qr/userunknown/    },
    { 'n' => '01181', 'r' => qr/mesgtoobig/     },
    { 'n' => '01182', 'r' => qr/userunknown/    },
    { 'n' => '01183', 'r' => qr/suspend/        },
    { 'n' => '01184', 'r' => qr/filtered/       },
    { 'n' => '01185', 'r' => qr/expired/        },
    { 'n' => '01186', 'r' => qr/policyviolation/},
    { 'n' => '01187', 'r' => qr/policyviolation/},
    { 'n' => '01188', 'r' => qr/userunknown/    },
    { 'n' => '01189', 'r' => qr/expired/        },
    { 'n' => '01190', 'r' => qr/securityerror/  },  # spamdetected
    { 'n' => '01191', 'r' => qr/suspend/        },
    { 'n' => '01192', 'r' => qr/userunknown/    },
    { 'n' => '01193', 'r' => qr/userunknown/    },
    { 'n' => '01194', 'r' => qr/suspend/        },
    { 'n' => '01195', 'r' => qr/policyviolation/},
    { 'n' => '01196', 'r' => qr/suspend/        },
    { 'n' => '01197', 'r' => qr/userunknown/    },
    { 'n' => '01198', 'r' => qr/userunknown/    },
    { 'n' => '01199', 'r' => qr/blocked/        },
    { 'n' => '01200', 'r' => qr/hostunknown/    },
    { 'n' => '01201', 'r' => qr/spamdetected/   },
    { 'n' => '01202', 'r' => qr/systemfull/     },
    { 'n' => '01203', 'r' => qr/securityerror/  }, # spamdetected
    { 'n' => '01204', 'r' => qr/suspend/        },
    { 'n' => '01205', 'r' => qr/userunknown/    },
    { 'n' => '01206', 'r' => qr/systemerror/    },
    { 'n' => '01207', 'r' => qr/userunknown/    },
    { 'n' => '01208', 'r' => qr/expired/        },
    { 'n' => '01209', 'r' => qr/spamdetected/   },
    { 'n' => '01210', 'r' => qr/userunknown/    },
    { 'n' => '01211', 'r' => qr/userunknown/    },
    { 'n' => '01212', 'r' => qr/filtered/       },
    { 'n' => '01213', 'r' => qr/filtered/       },
    { 'n' => '01214', 'r' => qr/userunknown/    },
    { 'n' => '01215', 'r' => qr/userunknown/    },
    { 'n' => '01216', 'r' => qr/userunknown/    },
    { 'n' => '01217', 'r' => qr/blocked/        },
    { 'n' => '01218', 'r' => qr/blocked/        },
];

plan 'skip_all', sprintf("%s not found", $samplepath) unless -d $samplepath;
$enginetest->($enginename, $isexpected, 1, 0);
done_testing;

