class CfgSettings {
    class CBA {
        class Caching {
            // did not turn on--not sure if using CBA caching
            functions = 0;
        };
        // @see https://github.com/CBATeam/CBA_A3/wiki/Versioning-System
        class Versioning {
            class PREFIX {
                class dependencies {
                    CBA_A3[] = {"cba_main", REQUIRED_CBA_VERSION, "(true)"};
                    ACE3[] = {"ace_main", REQUIRED_ACE_VERSION, "(true)"};
                };
            };
        };
    };
};
