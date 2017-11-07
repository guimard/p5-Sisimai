use strict;
use warnings;
use Test::More;
use lib qw(./lib ./blib/lib);
require './t/600-bite-email-code';

my $enginename = 'RFC3464';
my $samplepath = sprintf("./set-of-emails/private/%s", lc $enginename);
my $enginetest = Sisimai::Bite::Email::Code->maketest;
my $isexpected = [
    { 'n' => '01001', 'r' => qr/expired/        },
    { 'n' => '01002', 'r' => qr/userunknown/    },
    { 'n' => '01003', 'r' => qr/mesgtoobig/     },
    { 'n' => '01004', 'r' => qr/filtered/       },
    { 'n' => '01005', 'r' => qr/networkerror/   },
    { 'n' => '01007', 'r' => qr/onhold/         },
    { 'n' => '01008', 'r' => qr/expired/        },
    { 'n' => '01009', 'r' => qr/userunknown/    },
    { 'n' => '01011', 'r' => qr/hostunknown/    },
    { 'n' => '01013', 'r' => qr/filtered/       },
    { 'n' => '01014', 'r' => qr/userunknown/    },
    { 'n' => '01015', 'r' => qr/hostunknown/    },
    { 'n' => '01016', 'r' => qr/userunknown/    },
    { 'n' => '01017', 'r' => qr/userunknown/    },
    { 'n' => '01018', 'r' => qr/mailboxfull/    },
    { 'n' => '01019', 'r' => qr/filtered/       },
    { 'n' => '01020', 'r' => qr/userunknown/    },
    { 'n' => '01021', 'r' => qr/filtered/       },
    { 'n' => '01022', 'r' => qr/userunknown/    },
    { 'n' => '01023', 'r' => qr/filtered/       },
    { 'n' => '01024', 'r' => qr/userunknown/    },
    { 'n' => '01025', 'r' => qr/filtered/       },
    { 'n' => '01026', 'r' => qr/filtered/       },
    { 'n' => '01027', 'r' => qr/filtered/       },
    { 'n' => '01029', 'r' => qr/filtered/       },
    { 'n' => '01031', 'r' => qr/userunknown/    },
    { 'n' => '01033', 'r' => qr/userunknown/    },
    { 'n' => '01035', 'r' => qr/userunknown/    },
    { 'n' => '01036', 'r' => qr/filtered/       },
    { 'n' => '01037', 'r' => qr/systemerror/    },
    { 'n' => '01038', 'r' => qr/filtered/       },
    { 'n' => '01039', 'r' => qr/hostunknown/    },
    { 'n' => '01040', 'r' => qr/networkerror/   },
    { 'n' => '01041', 'r' => qr/filtered/       },
    { 'n' => '01042', 'r' => qr/filtered/       },
    { 'n' => '01043', 'r' => qr/(?:filtered|onhold)/ },
    { 'n' => '01044', 'r' => qr/userunknown/    },
    { 'n' => '01045', 'r' => qr/userunknown/    },
    { 'n' => '01046', 'r' => qr/userunknown/    },
    { 'n' => '01047', 'r' => qr/undefined/      },
    { 'n' => '01048', 'r' => qr/filtered/       },
    { 'n' => '01049', 'r' => qr/userunknown/    },
    { 'n' => '01050', 'r' => qr/filtered/       },
    { 'n' => '01051', 'r' => qr/userunknown/    },
    { 'n' => '01052', 'r' => qr/undefined/      },
    { 'n' => '01053', 'r' => qr/mailererror/    },
    { 'n' => '01054', 'r' => qr/undefined/      },
    { 'n' => '01055', 'r' => qr/filtered/       },
    { 'n' => '01056', 'r' => qr/mailboxfull/    },
    { 'n' => '01057', 'r' => qr/filtered/       },
    { 'n' => '01058', 'r' => qr/undefined/      },
    { 'n' => '01059', 'r' => qr/userunknown/    },
    { 'n' => '01060', 'r' => qr/filtered/       },
    { 'n' => '01061', 'r' => qr/hasmoved/       },
    { 'n' => '01062', 'r' => qr/userunknown/    },
    { 'n' => '01063', 'r' => qr/filtered/       },
    { 'n' => '01064', 'r' => qr/filtered/       },
    { 'n' => '01065', 'r' => qr/spamdetected/   },
    { 'n' => '01066', 'r' => qr/filtered/       },
    { 'n' => '01067', 'r' => qr/systemerror/    },
    { 'n' => '01068', 'r' => qr/undefined/      },
    { 'n' => '01069', 'r' => qr/expired/        },
    { 'n' => '01070', 'r' => qr/userunknown/    },
    { 'n' => '01071', 'r' => qr/mailboxfull/    },
    { 'n' => '01072', 'r' => qr/filtered/       },
    { 'n' => '01073', 'r' => qr/filtered/       },
    { 'n' => '01074', 'r' => qr/filtered/       },
    { 'n' => '01075', 'r' => qr/filtered/       },
    { 'n' => '01076', 'r' => qr/systemerror/    },
    { 'n' => '01077', 'r' => qr/filtered/       },
    { 'n' => '01078', 'r' => qr/userunknown/    },
    { 'n' => '01079', 'r' => qr/filtered/       },
    { 'n' => '01081', 'r' => qr/(?:filtered|syntaxerror)/ },
    { 'n' => '01083', 'r' => qr/filtered/       },
    { 'n' => '01085', 'r' => qr/filtered/       },
    { 'n' => '01086', 'r' => qr/(?:filtered|delivered)/ },
    { 'n' => '01087', 'r' => qr/filtered/       },
    { 'n' => '01088', 'r' => qr/onhold/         },
    { 'n' => '01089', 'r' => qr/filtered/       },
    { 'n' => '01090', 'r' => qr/filtered/       },
    { 'n' => '01091', 'r' => qr/undefined/      },
    { 'n' => '01092', 'r' => qr/undefined/      },
    { 'n' => '01093', 'r' => qr/filtered/       },
    { 'n' => '01095', 'r' => qr/filtered/       },
    { 'n' => '01096', 'r' => qr/filtered/       },
    { 'n' => '01097', 'r' => qr/filtered/       },
    { 'n' => '01098', 'r' => qr/filtered/       },
    { 'n' => '01099', 'r' => qr/securityerror/  },
    { 'n' => '01100', 'r' => qr/securityerror/  },
    { 'n' => '01101', 'r' => qr/filtered/       },
    { 'n' => '01102', 'r' => qr/filtered/       },
    { 'n' => '01103', 'r' => qr/expired/        },
    { 'n' => '01104', 'r' => qr/filtered/       },
    { 'n' => '01105', 'r' => qr/filtered/       },
    { 'n' => '01106', 'r' => qr/expired/        },
    { 'n' => '01107', 'r' => qr/filtered/       },
    { 'n' => '01108', 'r' => qr/undefined/      },
    { 'n' => '01109', 'r' => qr/onhold/         },
    { 'n' => '01111', 'r' => qr/mailboxfull/    },
    { 'n' => '01112', 'r' => qr/filtered/       },
    { 'n' => '01113', 'r' => qr/filtered/       },
    { 'n' => '01114', 'r' => qr/systemerror/    },
    { 'n' => '01115', 'r' => qr/expired/        },
    { 'n' => '01116', 'r' => qr/mailboxfull/    },
    { 'n' => '01117', 'r' => qr/mesgtoobig/     },
    { 'n' => '01118', 'r' => qr/expired/        },
    { 'n' => '01120', 'r' => qr/filtered/       },
    { 'n' => '01121', 'r' => qr/expired/        },
    { 'n' => '01122', 'r' => qr/filtered/       },
    { 'n' => '01123', 'r' => qr/expired/        },
    { 'n' => '01124', 'r' => qr/mailererror/    },
    { 'n' => '01125', 'r' => qr/networkerror/   },
    { 'n' => '01126', 'r' => qr/userunknown/    },
    { 'n' => '01127', 'r' => qr/filtered/       },
    { 'n' => '01128', 'r' => qr/(?:systemerror|onhold)/ },
    { 'n' => '01129', 'r' => qr/userunknown/    },
    { 'n' => '01130', 'r' => qr/systemerror/    },
    { 'n' => '01131', 'r' => qr/userunknown/    },
    { 'n' => '01132', 'r' => qr/systemerror/    },
    { 'n' => '01133', 'r' => qr/systemerror/    },
    { 'n' => '01134', 'r' => qr/filtered/       },
    { 'n' => '01135', 'r' => qr/userunknown/    },
    { 'n' => '01136', 'r' => qr/undefined/      },
    { 'n' => '01137', 'r' => qr/spamdetected/   },
    { 'n' => '01138', 'r' => qr/userunknown/    },
    { 'n' => '01139', 'r' => qr/expired/        },
    { 'n' => '01140', 'r' => qr/filtered/       },
    { 'n' => '01142', 'r' => qr/filtered/       },
    { 'n' => '01143', 'r' => qr/undefined/      },
    { 'n' => '01144', 'r' => qr/filtered/       },
    { 'n' => '01145', 'r' => qr/mailboxfull/    },
    { 'n' => '01146', 'r' => qr/mailboxfull/    },
    { 'n' => '01148', 'r' => qr/mailboxfull/    },
    { 'n' => '01149', 'r' => qr/expired/        },
    { 'n' => '01150', 'r' => qr/mailboxfull/    },
    { 'n' => '01151', 'r' => qr/exceedlimit/    },
    { 'n' => '01153', 'r' => qr/onhold/         },
    { 'n' => '01154', 'r' => qr/userunknown/    },
    { 'n' => '01155', 'r' => qr/networkerror/   },
    { 'n' => '01156', 'r' => qr/spamdetected/   },
    { 'n' => '01157', 'r' => qr/filtered/       },
    { 'n' => '01158', 'r' => qr/(?:expired|onhold)/ },
    { 'n' => '01159', 'r' => qr/mailboxfull/    },
    { 'n' => '01160', 'r' => qr/filtered/       },
    { 'n' => '01161', 'r' => qr/mailererror/    },
    { 'n' => '01162', 'r' => qr/filtered/       },
    { 'n' => '01163', 'r' => qr/mesgtoobig/     },
    { 'n' => '01164', 'r' => qr/userunknown/    },
    { 'n' => '01165', 'r' => qr/networkerror/   },
    { 'n' => '01166', 'r' => qr/systemerror/    },
    { 'n' => '01167', 'r' => qr/hostunknown/    },
    { 'n' => '01168', 'r' => qr/mailboxfull/    },
    { 'n' => '01169', 'r' => qr/userunknown/    },
    { 'n' => '01170', 'r' => qr/onhold/         },
    { 'n' => '01171', 'r' => qr/onhold/         },
    { 'n' => '01172', 'r' => qr/mailboxfull/    },
    { 'n' => '01173', 'r' => qr/networkerror/   },
    { 'n' => '01174', 'r' => qr/expired/        },
    { 'n' => '01175', 'r' => qr/filtered/       },
    { 'n' => '01176', 'r' => qr/filtered/       },
    { 'n' => '01177', 'r' => qr/(?:filtered|onhold)/ },
    { 'n' => '01178', 'r' => qr/filtered/       },
    { 'n' => '01179', 'r' => qr/userunknown/    },
    { 'n' => '01180', 'r' => qr/mailboxfull/    },
    { 'n' => '01181', 'r' => qr/filtered/       },
    { 'n' => '01182', 'r' => qr/onhold/         },
    { 'n' => '01183', 'r' => qr/mailboxfull/    },
    { 'n' => '01184', 'r' => qr/(?:undefined|onhold)/ },
    { 'n' => '01185', 'r' => qr/networkerror/   },
    { 'n' => '01186', 'r' => qr/networkerror/   },
    { 'n' => '01187', 'r' => qr/userunknown/    },
    { 'n' => '01188', 'r' => qr/userunknown/    },
    { 'n' => '01189', 'r' => qr/userunknown/    },
    { 'n' => '01190', 'r' => qr/userunknown/    },
    { 'n' => '01191', 'r' => qr/userunknown/    },
    { 'n' => '01192', 'r' => qr/userunknown/    },
    { 'n' => '01193', 'r' => qr/userunknown/    },
    { 'n' => '01194', 'r' => qr/userunknown/    },
    { 'n' => '01195', 'r' => qr/norelaying/     },
    { 'n' => '01196', 'r' => qr/userunknown/    },
    { 'n' => '01197', 'r' => qr/userunknown/    },
    { 'n' => '01198', 'r' => qr/userunknown/    },
    { 'n' => '01199', 'r' => qr/userunknown/    },
    { 'n' => '01200', 'r' => qr/userunknown/    },
    { 'n' => '01201', 'r' => qr/userunknown/    },
    { 'n' => '01202', 'r' => qr/userunknown/    },
    { 'n' => '01203', 'r' => qr/userunknown/    },
    { 'n' => '01204', 'r' => qr/userunknown/    },
    { 'n' => '01205', 'r' => qr/userunknown/    },
    { 'n' => '01206', 'r' => qr/userunknown/    },
    { 'n' => '01207', 'r' => qr/securityerror/  },
    { 'n' => '01208', 'r' => qr/userunknown/    },
    { 'n' => '01209', 'r' => qr/userunknown/    },
    { 'n' => '01210', 'r' => qr/userunknown/    },
    { 'n' => '01211', 'r' => qr/userunknown/    },
    { 'n' => '01212', 'r' => qr/mailboxfull/    },
    { 'n' => '01213', 'r' => qr/spamdetected/   },
    { 'n' => '01214', 'r' => qr/spamdetected/   },
    { 'n' => '01215', 'r' => qr/spamdetected/   },
    { 'n' => '01216', 'r' => qr/onhold/         },
    { 'n' => '01217', 'r' => qr/userunknown/    },
    { 'n' => '01218', 'r' => qr/mailboxfull/    },
    { 'n' => '01219', 'r' => qr/onhold/         },
    { 'n' => '01220', 'r' => qr/filtered/       },
    { 'n' => '01221', 'r' => qr/filtered/       },
    { 'n' => '01222', 'r' => qr/mailboxfull/    },
    { 'n' => '01223', 'r' => qr/mailboxfull/    },
    { 'n' => '01224', 'r' => qr/filtered/       },
    { 'n' => '01225', 'r' => qr/expired/        },
    { 'n' => '01226', 'r' => qr/filtered/       },
    { 'n' => '01227', 'r' => qr/userunknown/    },
    { 'n' => '01228', 'r' => qr/onhold/         },
    { 'n' => '01229', 'r' => qr/filtered/       },
    { 'n' => '01230', 'r' => qr/filtered/       },
    { 'n' => '01231', 'r' => qr/filtered/       },
    { 'n' => '01232', 'r' => qr/networkerror/   },
    { 'n' => '01233', 'r' => qr/mailererror/    },
    { 'n' => '01234', 'r' => qr/(?:filtered|onhold)/ },
    { 'n' => '01235', 'r' => qr/filtered/       },
    { 'n' => '01236', 'r' => qr/userunknown/    },
    { 'n' => '01237', 'r' => qr/userunknown/    },
    { 'n' => '01238', 'r' => qr/userunknown/    },
    { 'n' => '01239', 'r' => qr/userunknown/    },
    { 'n' => '01240', 'r' => qr/userunknown/    },
    { 'n' => '01241', 'r' => qr/userunknown/    },
    { 'n' => '01242', 'r' => qr/userunknown/    },
    { 'n' => '01243', 'r' => qr/syntaxerror/    },
    { 'n' => '01244', 'r' => qr/mailboxfull/    },
    { 'n' => '01245', 'r' => qr/mailboxfull/    },
    { 'n' => '01246', 'r' => qr/userunknown/    },
    { 'n' => '01247', 'r' => qr/userunknown/    },
    { 'n' => '01248', 'r' => qr/mailboxfull/    },
    { 'n' => '01249', 'r' => qr/syntaxerror/    },
    { 'n' => '01250', 'r' => qr/mailboxfull/    },
    { 'n' => '01251', 'r' => qr/mailboxfull/    },
    { 'n' => '01252', 'r' => qr/networkerror/   },
    { 'n' => '01253', 'r' => qr/hostunknown/    },
    { 'n' => '01254', 'r' => qr/userunknown/    },
    { 'n' => '01255', 'r' => qr/expired/        },
    { 'n' => '01256', 'r' => qr/onhold/         },
    { 'n' => '01257', 'r' => qr/onhold/         },
    { 'n' => '01258', 'r' => qr/userunknown/    },
    { 'n' => '01259', 'r' => qr/spamdetected/   },
];

plan 'skip_all', sprintf("%s not found", $samplepath) unless -d $samplepath;
$enginetest->($enginename, $isexpected, 1, 0);
done_testing;

