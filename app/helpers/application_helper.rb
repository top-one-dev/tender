module ApplicationHelper
	
	def country_list
    [ 
      {name: 'Afghanistan', code: 'AF'}, 
      {name: 'Åland Islands', code: 'AX'}, 
      {name: 'Albania', code: 'AL'}, 
      {name: 'Algeria', code: 'DZ'}, 
      {name: 'American Samoa', code: 'AS'}, 
      {name: 'AndorrA', code: 'AD'}, 
      {name: 'Angola', code: 'AO'}, 
      {name: 'Anguilla', code: 'AI'}, 
      {name: 'Antarctica', code: 'AQ'}, 
      {name: 'Antigua and Barbuda', code: 'AG'}, 
      {name: 'Argentina', code: 'AR'}, 
      {name: 'Armenia', code: 'AM'}, 
      {name: 'Aruba', code: 'AW'}, 
      {name: 'Australia', code: 'AU'}, 
      {name: 'Austria', code: 'AT'}, 
      {name: 'Azerbaijan', code: 'AZ'}, 
      {name: 'Bahamas', code: 'BS'}, 
      {name: 'Bahrain', code: 'BH'}, 
      {name: 'Bangladesh', code: 'BD'}, 
      {name: 'Barbados', code: 'BB'}, 
      {name: 'Belarus', code: 'BY'}, 
      {name: 'Belgium', code: 'BE'}, 
      {name: 'Belize', code: 'BZ'}, 
      {name: 'Benin', code: 'BJ'}, 
      {name: 'Bermuda', code: 'BM'}, 
      {name: 'Bhutan', code: 'BT'}, 
      {name: 'Bolivia', code: 'BO'}, 
      {name: 'Bosnia and Herzegovina', code: 'BA'}, 
      {name: 'Botswana', code: 'BW'}, 
      {name: 'Bouvet Island', code: 'BV'}, 
      {name: 'Brazil', code: 'BR'}, 
      {name: 'British Indian Ocean Territory', code: 'IO'}, 
      {name: 'Brunei Darussalam', code: 'BN'}, 
      {name: 'Bulgaria', code: 'BG'}, 
      {name: 'Burkina Faso', code: 'BF'}, 
      {name: 'Burundi', code: 'BI'}, 
      {name: 'Cambodia', code: 'KH'}, 
      {name: 'Cameroon', code: 'CM'}, 
      {name: 'Canada', code: 'CA'}, 
      {name: 'Cape Verde', code: 'CV'}, 
      {name: 'Cayman Islands', code: 'KY'}, 
      {name: 'Central African Republic', code: 'CF'}, 
      {name: 'Chad', code: 'TD'}, 
      {name: 'Chile', code: 'CL'}, 
      {name: 'China', code: 'CN'}, 
      {name: 'Christmas Island', code: 'CX'}, 
      {name: 'Cocos (Keeling) Islands', code: 'CC'}, 
      {name: 'Colombia', code: 'CO'}, 
      {name: 'Comoros', code: 'KM'}, 
      {name: 'Congo', code: 'CG'}, 
      {name: 'Congo, The Democratic Republic of the', code: 'CD'}, 
      {name: 'Cook Islands', code: 'CK'}, 
      {name: 'Costa Rica', code: 'CR'}, 
      {name: 'Cote D\'Ivoire', code: 'CI'}, 
      {name: 'Croatia', code: 'HR'}, 
      {name: 'Cuba', code: 'CU'}, 
      {name: 'Cyprus', code: 'CY'}, 
      {name: 'Czech Republic', code: 'CZ'}, 
      {name: 'Denmark', code: 'DK'}, 
      {name: 'Djibouti', code: 'DJ'}, 
      {name: 'Dominica', code: 'DM'}, 
      {name: 'Dominican Republic', code: 'DO'}, 
      {name: 'Ecuador', code: 'EC'}, 
      {name: 'Egypt', code: 'EG'}, 
      {name: 'El Salvador', code: 'SV'}, 
      {name: 'Equatorial Guinea', code: 'GQ'}, 
      {name: 'Eritrea', code: 'ER'}, 
      {name: 'Estonia', code: 'EE'}, 
      {name: 'Ethiopia', code: 'ET'}, 
      {name: 'Falkland Islands (Malvinas)', code: 'FK'}, 
      {name: 'Faroe Islands', code: 'FO'}, 
      {name: 'Fiji', code: 'FJ'}, 
      {name: 'Finland', code: 'FI'}, 
      {name: 'France', code: 'FR'}, 
      {name: 'French Guiana', code: 'GF'}, 
      {name: 'French Polynesia', code: 'PF'}, 
      {name: 'French Southern Territories', code: 'TF'}, 
      {name: 'Gabon', code: 'GA'}, 
      {name: 'Gambia', code: 'GM'}, 
      {name: 'Georgia', code: 'GE'}, 
      {name: 'Germany', code: 'DE'}, 
      {name: 'Ghana', code: 'GH'}, 
      {name: 'Gibraltar', code: 'GI'}, 
      {name: 'Greece', code: 'GR'}, 
      {name: 'Greenland', code: 'GL'}, 
      {name: 'Grenada', code: 'GD'}, 
      {name: 'Guadeloupe', code: 'GP'}, 
      {name: 'Guam', code: 'GU'}, 
      {name: 'Guatemala', code: 'GT'}, 
      {name: 'Guernsey', code: 'GG'}, 
      {name: 'Guinea', code: 'GN'}, 
      {name: 'Guinea-Bissau', code: 'GW'}, 
      {name: 'Guyana', code: 'GY'}, 
      {name: 'Haiti', code: 'HT'}, 
      {name: 'Heard Island and Mcdonald Islands', code: 'HM'}, 
      {name: 'Holy See (Vatican City State)', code: 'VA'}, 
      {name: 'Honduras', code: 'HN'}, 
      {name: 'Hong Kong', code: 'HK'}, 
      {name: 'Hungary', code: 'HU'}, 
      {name: 'Iceland', code: 'IS'}, 
      {name: 'India', code: 'IN'}, 
      {name: 'Indonesia', code: 'ID'}, 
      {name: 'Iran, Islamic Republic Of', code: 'IR'}, 
      {name: 'Iraq', code: 'IQ'}, 
      {name: 'Ireland', code: 'IE'}, 
      {name: 'Isle of Man', code: 'IM'}, 
      {name: 'Israel', code: 'IL'}, 
      {name: 'Italy', code: 'IT'}, 
      {name: 'Jamaica', code: 'JM'}, 
      {name: 'Japan', code: 'JP'}, 
      {name: 'Jersey', code: 'JE'}, 
      {name: 'Jordan', code: 'JO'}, 
      {name: 'Kazakhstan', code: 'KZ'}, 
      {name: 'Kenya', code: 'KE'}, 
      {name: 'Kiribati', code: 'KI'}, 
      {name: 'Korea, Democratic People\'S Republic of', code: 'KP'}, 
      {name: 'Korea, Republic of', code: 'KR'}, 
      {name: 'Kuwait', code: 'KW'}, 
      {name: 'Kyrgyzstan', code: 'KG'}, 
      {name: 'Lao People\'S Democratic Republic', code: 'LA'}, 
      {name: 'Latvia', code: 'LV'}, 
      {name: 'Lebanon', code: 'LB'}, 
      {name: 'Lesotho', code: 'LS'}, 
      {name: 'Liberia', code: 'LR'}, 
      {name: 'Libyan Arab Jamahiriya', code: 'LY'}, 
      {name: 'Liechtenstein', code: 'LI'}, 
      {name: 'Lithuania', code: 'LT'}, 
      {name: 'Luxembourg', code: 'LU'}, 
      {name: 'Macao', code: 'MO'}, 
      {name: 'Macedonia, The Former Yugoslav Republic of', code: 'MK'}, 
      {name: 'Madagascar', code: 'MG'}, 
      {name: 'Malawi', code: 'MW'}, 
      {name: 'Malaysia', code: 'MY'}, 
      {name: 'Maldives', code: 'MV'}, 
      {name: 'Mali', code: 'ML'}, 
      {name: 'Malta', code: 'MT'}, 
      {name: 'Marshall Islands', code: 'MH'}, 
      {name: 'Martinique', code: 'MQ'}, 
      {name: 'Mauritania', code: 'MR'}, 
      {name: 'Mauritius', code: 'MU'}, 
      {name: 'Mayotte', code: 'YT'}, 
      {name: 'Mexico', code: 'MX'}, 
      {name: 'Micronesia, Federated States of', code: 'FM'}, 
      {name: 'Moldova, Republic of', code: 'MD'}, 
      {name: 'Monaco', code: 'MC'}, 
      {name: 'Mongolia', code: 'MN'}, 
      {name: 'Montserrat', code: 'MS'}, 
      {name: 'Morocco', code: 'MA'}, 
      {name: 'Mozambique', code: 'MZ'}, 
      {name: 'Myanmar', code: 'MM'}, 
      {name: 'Namibia', code: 'NA'}, 
      {name: 'Nauru', code: 'NR'}, 
      {name: 'Nepal', code: 'NP'}, 
      {name: 'Netherlands', code: 'NL'}, 
      {name: 'Netherlands Antilles', code: 'AN'}, 
      {name: 'New Caledonia', code: 'NC'}, 
      {name: 'New Zealand', code: 'NZ'}, 
      {name: 'Nicaragua', code: 'NI'}, 
      {name: 'Niger', code: 'NE'}, 
      {name: 'Nigeria', code: 'NG'}, 
      {name: 'Niue', code: 'NU'}, 
      {name: 'Norfolk Island', code: 'NF'}, 
      {name: 'Northern Mariana Islands', code: 'MP'}, 
      {name: 'Norway', code: 'NO'}, 
      {name: 'Oman', code: 'OM'}, 
      {name: 'Pakistan', code: 'PK'}, 
      {name: 'Palau', code: 'PW'}, 
      {name: 'Palestinian Territory, Occupied', code: 'PS'}, 
      {name: 'Panama', code: 'PA'}, 
      {name: 'Papua New Guinea', code: 'PG'}, 
      {name: 'Paraguay', code: 'PY'}, 
      {name: 'Peru', code: 'PE'}, 
      {name: 'Philippines', code: 'PH'}, 
      {name: 'Pitcairn', code: 'PN'}, 
      {name: 'Poland', code: 'PL'}, 
      {name: 'Portugal', code: 'PT'}, 
      {name: 'Puerto Rico', code: 'PR'}, 
      {name: 'Qatar', code: 'QA'}, 
      {name: 'Reunion', code: 'RE'}, 
      {name: 'Romania', code: 'RO'}, 
      {name: 'Russian Federation', code: 'RU'}, 
      {name: 'RWANDA', code: 'RW'}, 
      {name: 'Saint Helena', code: 'SH'}, 
      {name: 'Saint Kitts and Nevis', code: 'KN'}, 
      {name: 'Saint Lucia', code: 'LC'}, 
      {name: 'Saint Pierre and Miquelon', code: 'PM'}, 
      {name: 'Saint Vincent and the Grenadines', code: 'VC'}, 
      {name: 'Samoa', code: 'WS'}, 
      {name: 'San Marino', code: 'SM'}, 
      {name: 'Sao Tome and Principe', code: 'ST'}, 
      {name: 'Saudi Arabia', code: 'SA'}, 
      {name: 'Senegal', code: 'SN'}, 
      {name: 'Serbia and Montenegro', code: 'CS'}, 
      {name: 'Seychelles', code: 'SC'}, 
      {name: 'Sierra Leone', code: 'SL'}, 
      {name: 'Singapore', code: 'SG'}, 
      {name: 'Slovakia', code: 'SK'}, 
      {name: 'Slovenia', code: 'SI'}, 
      {name: 'Solomon Islands', code: 'SB'}, 
      {name: 'Somalia', code: 'SO'}, 
      {name: 'South Africa', code: 'ZA'}, 
      {name: 'South Georgia and the South Sandwich Islands', code: 'GS'}, 
      {name: 'Spain', code: 'ES'}, 
      {name: 'Sri Lanka', code: 'LK'}, 
      {name: 'Sudan', code: 'SD'}, 
      {name: 'Suriname', code: 'SR'}, 
      {name: 'Svalbard and Jan Mayen', code: 'SJ'}, 
      {name: 'Swaziland', code: 'SZ'}, 
      {name: 'Sweden', code: 'SE'}, 
      {name: 'Switzerland', code: 'CH'}, 
      {name: 'Syrian Arab Republic', code: 'SY'}, 
      {name: 'Taiwan, Province of China', code: 'TW'}, 
      {name: 'Tajikistan', code: 'TJ'}, 
      {name: 'Tanzania, United Republic of', code: 'TZ'}, 
      {name: 'Thailand', code: 'TH'}, 
      {name: 'Timor-Leste', code: 'TL'}, 
      {name: 'Togo', code: 'TG'}, 
      {name: 'Tokelau', code: 'TK'}, 
      {name: 'Tonga', code: 'TO'}, 
      {name: 'Trinidad and Tobago', code: 'TT'}, 
      {name: 'Tunisia', code: 'TN'}, 
      {name: 'Turkey', code: 'TR'}, 
      {name: 'Turkmenistan', code: 'TM'}, 
      {name: 'Turks and Caicos Islands', code: 'TC'}, 
      {name: 'Tuvalu', code: 'TV'}, 
      {name: 'Uganda', code: 'UG'}, 
      {name: 'Ukraine', code: 'UA'}, 
      {name: 'United Arab Emirates', code: 'AE'}, 
      {name: 'United Kingdom', code: 'GB'}, 
      {name: 'United States', code: 'US'}, 
      {name: 'United States Minor Outlying Islands', code: 'UM'}, 
      {name: 'Uruguay', code: 'UY'}, 
      {name: 'Uzbekistan', code: 'UZ'}, 
      {name: 'Vanuatu', code: 'VU'}, 
      {name: 'Venezuela', code: 'VE'}, 
      {name: 'Viet Nam', code: 'VN'}, 
      {name: 'Virgin Islands, British', code: 'VG'}, 
      {name: 'Virgin Islands, U.S.', code: 'VI'}, 
      {name: 'Wallis and Futuna', code: 'WF'}, 
      {name: 'Western Sahara', code: 'EH'}, 
      {name: 'Yemen', code: 'YE'}, 
      {name: 'Zambia', code: 'ZM'}, 
      {name: 'Zimbabwe', code: 'ZW'} 
    ]
  end

  def timezone_list
    [
      {
        "value": "Dateline Standard Time",
        "abbr": "DST",
        "offset": -12,
        "isdst": false,
        "text": "(UTC-12:00) International Date Line West",
        "utc": [
          "Etc/GMT+12"
        ]
      },
      {
        "value": "UTC-11",
        "abbr": "U",
        "offset": -11,
        "isdst": false,
        "text": "(UTC-11:00) Coordinated Universal Time-11",
        "utc": [
          "Etc/GMT+11",
          "Pacific/Midway",
          "Pacific/Niue",
          "Pacific/Pago_Pago"
        ]
      },
      {
        "value": "Hawaiian Standard Time",
        "abbr": "HST",
        "offset": -10,
        "isdst": false,
        "text": "(UTC-10:00) Hawaii",
        "utc": [
          "Etc/GMT+10",
          "Pacific/Honolulu",
          "Pacific/Johnston",
          "Pacific/Rarotonga",
          "Pacific/Tahiti"
        ]
      },
      {
        "value": "Alaskan Standard Time",
        "abbr": "AKDT",
        "offset": -8,
        "isdst": true,
        "text": "(UTC-09:00) Alaska",
        "utc": [
          "America/Anchorage",
          "America/Juneau",
          "America/Nome",
          "America/Sitka",
          "America/Yakutat"
        ]
      },
      {
        "value": "Pacific Standard Time (Mexico)",
        "abbr": "PDT",
        "offset": -7,
        "isdst": true,
        "text": "(UTC-08:00) Baja California",
        "utc": [
          "America/Santa_Isabel"
        ]
      },
      {
        "value": "Pacific Standard Time",
        "abbr": "PDT",
        "offset": -7,
        "isdst": true,
        "text": "(UTC-08:00) Pacific Time (US & Canada)",
        "utc": [
          "America/Dawson",
          "America/Los_Angeles",
          "America/Tijuana",
          "America/Vancouver",
          "America/Whitehorse",
          "PST8PDT"
        ]
      },
      {
        "value": "US Mountain Standard Time",
        "abbr": "UMST",
        "offset": -7,
        "isdst": false,
        "text": "(UTC-07:00) Arizona",
        "utc": [
          "America/Creston",
          "America/Dawson_Creek",
          "America/Hermosillo",
          "America/Phoenix",
          "Etc/GMT+7"
        ]
      },
      {
        "value": "Mountain Standard Time (Mexico)",
        "abbr": "MDT",
        "offset": -6,
        "isdst": true,
        "text": "(UTC-07:00) Chihuahua, La Paz, Mazatlan",
        "utc": [
          "America/Chihuahua",
          "America/Mazatlan"
        ]
      },
      {
        "value": "Mountain Standard Time",
        "abbr": "MDT",
        "offset": -6,
        "isdst": true,
        "text": "(UTC-07:00) Mountain Time (US & Canada)",
        "utc": [
          "America/Boise",
          "America/Cambridge_Bay",
          "America/Denver",
          "America/Edmonton",
          "America/Inuvik",
          "America/Ojinaga",
          "America/Yellowknife",
          "MST7MDT"
        ]
      },
      {
        "value": "Central America Standard Time",
        "abbr": "CAST",
        "offset": -6,
        "isdst": false,
        "text": "(UTC-06:00) Central America",
        "utc": [
          "America/Belize",
          "America/Costa_Rica",
          "America/El_Salvador",
          "America/Guatemala",
          "America/Managua",
          "America/Tegucigalpa",
          "Etc/GMT+6",
          "Pacific/Galapagos"
        ]
      },
      {
        "value": "Central Standard Time",
        "abbr": "CDT",
        "offset": -5,
        "isdst": true,
        "text": "(UTC-06:00) Central Time (US & Canada)",
        "utc": [
          "America/Chicago",
          "America/Indiana/Knox",
          "America/Indiana/Tell_City",
          "America/Matamoros",
          "America/Menominee",
          "America/North_Dakota/Beulah",
          "America/North_Dakota/Center",
          "America/North_Dakota/New_Salem",
          "America/Rainy_River",
          "America/Rankin_Inlet",
          "America/Resolute",
          "America/Winnipeg",
          "CST6CDT"
        ]
      },
      {
        "value": "Central Standard Time (Mexico)",
        "abbr": "CDT",
        "offset": -5,
        "isdst": true,
        "text": "(UTC-06:00) Guadalajara, Mexico City, Monterrey",
        "utc": [
          "America/Bahia_Banderas",
          "America/Cancun",
          "America/Merida",
          "America/Mexico_City",
          "America/Monterrey"
        ]
      },
      {
        "value": "Canada Central Standard Time",
        "abbr": "CCST",
        "offset": -6,
        "isdst": false,
        "text": "(UTC-06:00) Saskatchewan",
        "utc": [
          "America/Regina",
          "America/Swift_Current"
        ]
      },
      {
        "value": "SA Pacific Standard Time",
        "abbr": "SPST",
        "offset": -5,
        "isdst": false,
        "text": "(UTC-05:00) Bogota, Lima, Quito",
        "utc": [
          "America/Bogota",
          "America/Cayman",
          "America/Coral_Harbour",
          "America/Eirunepe",
          "America/Guayaquil",
          "America/Jamaica",
          "America/Lima",
          "America/Panama",
          "America/Rio_Branco",
          "Etc/GMT+5"
        ]
      },
      {
        "value": "Eastern Standard Time",
        "abbr": "EDT",
        "offset": -4,
        "isdst": true,
        "text": "(UTC-05:00) Eastern Time (US & Canada)",
        "utc": [
          "America/Detroit",
          "America/Havana",
          "America/Indiana/Petersburg",
          "America/Indiana/Vincennes",
          "America/Indiana/Winamac",
          "America/Iqaluit",
          "America/Kentucky/Monticello",
          "America/Louisville",
          "America/Montreal",
          "America/Nassau",
          "America/New_York",
          "America/Nipigon",
          "America/Pangnirtung",
          "America/Port-au-Prince",
          "America/Thunder_Bay",
          "America/Toronto",
          "EST5EDT"
        ]
      },
      {
        "value": "US Eastern Standard Time",
        "abbr": "UEDT",
        "offset": -4,
        "isdst": true,
        "text": "(UTC-05:00) Indiana (East)",
        "utc": [
          "America/Indiana/Marengo",
          "America/Indiana/Vevay",
          "America/Indianapolis"
        ]
      },
      {
        "value": "Venezuela Standard Time",
        "abbr": "VST",
        "offset": -4.5,
        "isdst": false,
        "text": "(UTC-04:30) Caracas",
        "utc": [
          "America/Caracas"
        ]
      },
      {
        "value": "Paraguay Standard Time",
        "abbr": "PYT",
        "offset": -4,
        "isdst": false,
        "text": "(UTC-04:00) Asuncion",
        "utc": [
          "America/Asuncion"
        ]
      },
      {
        "value": "Atlantic Standard Time",
        "abbr": "ADT",
        "offset": -3,
        "isdst": true,
        "text": "(UTC-04:00) Atlantic Time (Canada)",
        "utc": [
          "America/Glace_Bay",
          "America/Goose_Bay",
          "America/Halifax",
          "America/Moncton",
          "America/Thule",
          "Atlantic/Bermuda"
        ]
      },
      {
        "value": "Central Brazilian Standard Time",
        "abbr": "CBST",
        "offset": -4,
        "isdst": false,
        "text": "(UTC-04:00) Cuiaba",
        "utc": [
          "America/Campo_Grande",
          "America/Cuiaba"
        ]
      },
      {
        "value": "SA Western Standard Time",
        "abbr": "SWST",
        "offset": -4,
        "isdst": false,
        "text": "(UTC-04:00) Georgetown, La Paz, Manaus, San Juan",
        "utc": [
          "America/Anguilla",
          "America/Antigua",
          "America/Aruba",
          "America/Barbados",
          "America/Blanc-Sablon",
          "America/Boa_Vista",
          "America/Curacao",
          "America/Dominica",
          "America/Grand_Turk",
          "America/Grenada",
          "America/Guadeloupe",
          "America/Guyana",
          "America/Kralendijk",
          "America/La_Paz",
          "America/Lower_Princes",
          "America/Manaus",
          "America/Marigot",
          "America/Martinique",
          "America/Montserrat",
          "America/Port_of_Spain",
          "America/Porto_Velho",
          "America/Puerto_Rico",
          "America/Santo_Domingo",
          "America/St_Barthelemy",
          "America/St_Kitts",
          "America/St_Lucia",
          "America/St_Thomas",
          "America/St_Vincent",
          "America/Tortola",
          "Etc/GMT+4"
        ]
      },
      {
        "value": "Pacific SA Standard Time",
        "abbr": "PSST",
        "offset": -4,
        "isdst": false,
        "text": "(UTC-04:00) Santiago",
        "utc": [
          "America/Santiago",
          "Antarctica/Palmer"
        ]
      },
      {
        "value": "Newfoundland Standard Time",
        "abbr": "NDT",
        "offset": -2.5,
        "isdst": true,
        "text": "(UTC-03:30) Newfoundland",
        "utc": [
          "America/St_Johns"
        ]
      },
      {
        "value": "E. South America Standard Time",
        "abbr": "ESAST",
        "offset": -3,
        "isdst": false,
        "text": "(UTC-03:00) Brasilia",
        "utc": [
          "America/Sao_Paulo"
        ]
      },
      {
        "value": "Argentina Standard Time",
        "abbr": "AST",
        "offset": -3,
        "isdst": false,
        "text": "(UTC-03:00) Buenos Aires",
        "utc": [
          "America/Argentina/La_Rioja",
          "America/Argentina/Rio_Gallegos",
          "America/Argentina/Salta",
          "America/Argentina/San_Juan",
          "America/Argentina/San_Luis",
          "America/Argentina/Tucuman",
          "America/Argentina/Ushuaia",
          "America/Buenos_Aires",
          "America/Catamarca",
          "America/Cordoba",
          "America/Jujuy",
          "America/Mendoza"
        ]
      },
      {
        "value": "SA Eastern Standard Time",
        "abbr": "SEST",
        "offset": -3,
        "isdst": false,
        "text": "(UTC-03:00) Cayenne, Fortaleza",
        "utc": [
          "America/Araguaina",
          "America/Belem",
          "America/Cayenne",
          "America/Fortaleza",
          "America/Maceio",
          "America/Paramaribo",
          "America/Recife",
          "America/Santarem",
          "Antarctica/Rothera",
          "Atlantic/Stanley",
          "Etc/GMT+3"
        ]
      },
      {
        "value": "Greenland Standard Time",
        "abbr": "GDT",
        "offset": -3,
        "isdst": true,
        "text": "(UTC-03:00) Greenland",
        "utc": [
          "America/Godthab"
        ]
      },
      {
        "value": "Montevideo Standard Time",
        "abbr": "MST",
        "offset": -3,
        "isdst": false,
        "text": "(UTC-03:00) Montevideo",
        "utc": [
          "America/Montevideo"
        ]
      },
      {
        "value": "Bahia Standard Time",
        "abbr": "BST",
        "offset": -3,
        "isdst": false,
        "text": "(UTC-03:00) Salvador",
        "utc": [
          "America/Bahia"
        ]
      },
      {
        "value": "UTC-02",
        "abbr": "U",
        "offset": -2,
        "isdst": false,
        "text": "(UTC-02:00) Coordinated Universal Time-02",
        "utc": [
          "America/Noronha",
          "Atlantic/South_Georgia",
          "Etc/GMT+2"
        ]
      },
      {
        "value": "Mid-Atlantic Standard Time",
        "abbr": "MDT",
        "offset": -1,
        "isdst": true,
        "text": "(UTC-02:00) Mid-Atlantic - Old",
        "utc": []
      },
      {
        "value": "Azores Standard Time",
        "abbr": "ADT",
        "offset": 0,
        "isdst": true,
        "text": "(UTC-01:00) Azores",
        "utc": [
          "America/Scoresbysund",
          "Atlantic/Azores"
        ]
      },
      {
        "value": "Cape Verde Standard Time",
        "abbr": "CVST",
        "offset": -1,
        "isdst": false,
        "text": "(UTC-01:00) Cape Verde Is.",
        "utc": [
          "Atlantic/Cape_Verde",
          "Etc/GMT+1"
        ]
      },
      {
        "value": "Morocco Standard Time",
        "abbr": "MDT",
        "offset": 1,
        "isdst": true,
        "text": "(UTC) Casablanca",
        "utc": [
          "Africa/Casablanca",
          "Africa/El_Aaiun"
        ]
      },
      {
        "value": "UTC",
        "abbr": "UTC",
        "offset": 0,
        "isdst": false,
        "text": "(UTC) Coordinated Universal Time",
        "utc": [
          "America/Danmarkshavn",
          "Etc/GMT"
        ]
      },
      {
        "value": "GMT Standard Time",
        "abbr": "GDT",
        "offset": 1,
        "isdst": true,
        "text": "(UTC) Dublin, Edinburgh, Lisbon, London",
        "utc": [
          "Atlantic/Canary",
          "Atlantic/Faeroe",
          "Atlantic/Madeira",
          "Europe/Dublin",
          "Europe/Guernsey",
          "Europe/Isle_of_Man",
          "Europe/Jersey",
          "Europe/Lisbon",
          "Europe/London"
        ]
      },
      {
        "value": "Greenwich Standard Time",
        "abbr": "GST",
        "offset": 0,
        "isdst": false,
        "text": "(UTC) Monrovia, Reykjavik",
        "utc": [
          "Africa/Abidjan",
          "Africa/Accra",
          "Africa/Bamako",
          "Africa/Banjul",
          "Africa/Bissau",
          "Africa/Conakry",
          "Africa/Dakar",
          "Africa/Freetown",
          "Africa/Lome",
          "Africa/Monrovia",
          "Africa/Nouakchott",
          "Africa/Ouagadougou",
          "Africa/Sao_Tome",
          "Atlantic/Reykjavik",
          "Atlantic/St_Helena"
        ]
      },
      {
        "value": "W. Europe Standard Time",
        "abbr": "WEDT",
        "offset": 2,
        "isdst": true,
        "text": "(UTC+01:00) Amsterdam, Berlin, Bern, Rome, Stockholm, Vienna",
        "utc": [
          "Arctic/Longyearbyen",
          "Europe/Amsterdam",
          "Europe/Andorra",
          "Europe/Berlin",
          "Europe/Busingen",
          "Europe/Gibraltar",
          "Europe/Luxembourg",
          "Europe/Malta",
          "Europe/Monaco",
          "Europe/Oslo",
          "Europe/Rome",
          "Europe/San_Marino",
          "Europe/Stockholm",
          "Europe/Vaduz",
          "Europe/Vatican",
          "Europe/Vienna",
          "Europe/Zurich"
        ]
      },
      {
        "value": "Central Europe Standard Time",
        "abbr": "CEDT",
        "offset": 2,
        "isdst": true,
        "text": "(UTC+01:00) Belgrade, Bratislava, Budapest, Ljubljana, Prague",
        "utc": [
          "Europe/Belgrade",
          "Europe/Bratislava",
          "Europe/Budapest",
          "Europe/Ljubljana",
          "Europe/Podgorica",
          "Europe/Prague",
          "Europe/Tirane"
        ]
      },
      {
        "value": "Romance Standard Time",
        "abbr": "RDT",
        "offset": 2,
        "isdst": true,
        "text": "(UTC+01:00) Brussels, Copenhagen, Madrid, Paris",
        "utc": [
          "Africa/Ceuta",
          "Europe/Brussels",
          "Europe/Copenhagen",
          "Europe/Madrid",
          "Europe/Paris"
        ]
      },
      {
        "value": "Central European Standard Time",
        "abbr": "CEDT",
        "offset": 2,
        "isdst": true,
        "text": "(UTC+01:00) Sarajevo, Skopje, Warsaw, Zagreb",
        "utc": [
          "Europe/Sarajevo",
          "Europe/Skopje",
          "Europe/Warsaw",
          "Europe/Zagreb"
        ]
      },
      {
        "value": "W. Central Africa Standard Time",
        "abbr": "WCAST",
        "offset": 1,
        "isdst": false,
        "text": "(UTC+01:00) West Central Africa",
        "utc": [
          "Africa/Algiers",
          "Africa/Bangui",
          "Africa/Brazzaville",
          "Africa/Douala",
          "Africa/Kinshasa",
          "Africa/Lagos",
          "Africa/Libreville",
          "Africa/Luanda",
          "Africa/Malabo",
          "Africa/Ndjamena",
          "Africa/Niamey",
          "Africa/Porto-Novo",
          "Africa/Tunis",
          "Etc/GMT-1"
        ]
      },
      {
        "value": "Namibia Standard Time",
        "abbr": "NST",
        "offset": 1,
        "isdst": false,
        "text": "(UTC+01:00) Windhoek",
        "utc": [
          "Africa/Windhoek"
        ]
      },
      {
        "value": "GTB Standard Time",
        "abbr": "GDT",
        "offset": 3,
        "isdst": true,
        "text": "(UTC+02:00) Athens, Bucharest",
        "utc": [
          "Asia/Nicosia",
          "Europe/Athens",
          "Europe/Bucharest",
          "Europe/Chisinau"
        ]
      },
      {
        "value": "Middle East Standard Time",
        "abbr": "MEDT",
        "offset": 3,
        "isdst": true,
        "text": "(UTC+02:00) Beirut",
        "utc": [
          "Asia/Beirut"
        ]
      },
      {
        "value": "Egypt Standard Time",
        "abbr": "EST",
        "offset": 2,
        "isdst": false,
        "text": "(UTC+02:00) Cairo",
        "utc": [
          "Africa/Cairo"
        ]
      },
      {
        "value": "Syria Standard Time",
        "abbr": "SDT",
        "offset": 3,
        "isdst": true,
        "text": "(UTC+02:00) Damascus",
        "utc": [
          "Asia/Damascus"
        ]
      },
      {
        "value": "E. Europe Standard Time",
        "abbr": "EEDT",
        "offset": 3,
        "isdst": true,
        "text": "(UTC+02:00) E. Europe",
        "utc": [
          "Asia/Nicosia",
          "Europe/Athens",
          "Europe/Bucharest",
          "Europe/Chisinau",
          "Europe/Helsinki",
          "Europe/Kiev",
          "Europe/Mariehamn",
          "Europe/Nicosia",
          "Europe/Riga",
          "Europe/Sofia",
          "Europe/Tallinn",
          "Europe/Uzhgorod",
          "Europe/Vilnius",
          "Europe/Zaporozhye"

        ]
      },
      {
        "value": "South Africa Standard Time",
        "abbr": "SAST",
        "offset": 2,
        "isdst": false,
        "text": "(UTC+02:00) Harare, Pretoria",
        "utc": [
          "Africa/Blantyre",
          "Africa/Bujumbura",
          "Africa/Gaborone",
          "Africa/Harare",
          "Africa/Johannesburg",
          "Africa/Kigali",
          "Africa/Lubumbashi",
          "Africa/Lusaka",
          "Africa/Maputo",
          "Africa/Maseru",
          "Africa/Mbabane",
          "Etc/GMT-2"
        ]
      },
      {
        "value": "FLE Standard Time",
        "abbr": "FDT",
        "offset": 3,
        "isdst": true,
        "text": "(UTC+02:00) Helsinki, Kyiv, Riga, Sofia, Tallinn, Vilnius",
        "utc": [
          "Europe/Helsinki",
          "Europe/Kiev",
          "Europe/Mariehamn",
          "Europe/Riga",
          "Europe/Sofia",
          "Europe/Tallinn",
          "Europe/Uzhgorod",
          "Europe/Vilnius",
          "Europe/Zaporozhye"
        ]
      },
      {
        "value": "Turkey Standard Time",
        "abbr": "TDT",
        "offset": 3,
        "isdst": false,
        "text": "(UTC+03:00) Istanbul",
        "utc": [
          "Europe/Istanbul"
        ]
      },
      {
        "value": "Israel Standard Time",
        "abbr": "JDT",
        "offset": 3,
        "isdst": true,
        "text": "(UTC+02:00) Jerusalem",
        "utc": [
          "Asia/Jerusalem"
        ]
      },
      {
        "value": "Libya Standard Time",
        "abbr": "LST",
        "offset": 2,
        "isdst": false,
        "text": "(UTC+02:00) Tripoli",
        "utc": [
          "Africa/Tripoli"
        ]
      },
      {
        "value": "Jordan Standard Time",
        "abbr": "JST",
        "offset": 3,
        "isdst": false,
        "text": "(UTC+03:00) Amman",
        "utc": [
          "Asia/Amman"
        ]
      },
      {
        "value": "Arabic Standard Time",
        "abbr": "AST",
        "offset": 3,
        "isdst": false,
        "text": "(UTC+03:00) Baghdad",
        "utc": [
          "Asia/Baghdad"
        ]
      },
      {
        "value": "Kaliningrad Standard Time",
        "abbr": "KST",
        "offset": 3,
        "isdst": false,
        "text": "(UTC+03:00) Kaliningrad, Minsk",
        "utc": [
          "Europe/Kaliningrad",
          "Europe/Minsk"
        ]
      },
      {
        "value": "Arab Standard Time",
        "abbr": "AST",
        "offset": 3,
        "isdst": false,
        "text": "(UTC+03:00) Kuwait, Riyadh",
        "utc": [
          "Asia/Aden",
          "Asia/Bahrain",
          "Asia/Kuwait",
          "Asia/Qatar",
          "Asia/Riyadh"
        ]
      },
      {
        "value": "E. Africa Standard Time",
        "abbr": "EAST",
        "offset": 3,
        "isdst": false,
        "text": "(UTC+03:00) Nairobi",
        "utc": [
          "Africa/Addis_Ababa",
          "Africa/Asmera",
          "Africa/Dar_es_Salaam",
          "Africa/Djibouti",
          "Africa/Juba",
          "Africa/Kampala",
          "Africa/Khartoum",
          "Africa/Mogadishu",
          "Africa/Nairobi",
          "Antarctica/Syowa",
          "Etc/GMT-3",
          "Indian/Antananarivo",
          "Indian/Comoro",
          "Indian/Mayotte"
        ]
      },
      {
        "value": "Moscow Standard Time",
        "abbr": "MSK",
        "offset": 3,
        "isdst": false,
        "text": "(UTC+03:00) Moscow, St. Petersburg, Volgograd",
        "utc": [
          "Europe/Kirov",
          "Europe/Moscow",
          "Europe/Simferopol",
          "Europe/Volgograd"
        ]
      },
      {
        "value": "Samara Time",
        "abbr": "SAMT",
        "offset": 4,
        "isdst": false,
        "text": "(UTC+04:00) Samara, Ulyanovsk, Saratov",
        "utc": [
          "Europe/Astrakhan",
          "Europe/Samara",
          "Europe/Ulyanovsk"
        ]
      },
      {
        "value": "Iran Standard Time",
        "abbr": "IDT",
        "offset": 4.5,
        "isdst": true,
        "text": "(UTC+03:30) Tehran",
        "utc": [
          "Asia/Tehran"
        ]
      },
      {
        "value": "Arabian Standard Time",
        "abbr": "AST",
        "offset": 4,
        "isdst": false,
        "text": "(UTC+04:00) Abu Dhabi, Muscat",
        "utc": [
          "Asia/Dubai",
          "Asia/Muscat",
          "Etc/GMT-4"
        ]
      },
      {
        "value": "Azerbaijan Standard Time",
        "abbr": "ADT",
        "offset": 5,
        "isdst": true,
        "text": "(UTC+04:00) Baku",
        "utc": [
          "Asia/Baku"
        ]
      },
      {
        "value": "Mauritius Standard Time",
        "abbr": "MST",
        "offset": 4,
        "isdst": false,
        "text": "(UTC+04:00) Port Louis",
        "utc": [
          "Indian/Mahe",
          "Indian/Mauritius",
          "Indian/Reunion"
        ]
      },
      {
        "value": "Georgian Standard Time",
        "abbr": "GST",
        "offset": 4,
        "isdst": false,
        "text": "(UTC+04:00) Tbilisi",
        "utc": [
          "Asia/Tbilisi"
        ]
      },
      {
        "value": "Caucasus Standard Time",
        "abbr": "CST",
        "offset": 4,
        "isdst": false,
        "text": "(UTC+04:00) Yerevan",
        "utc": [
          "Asia/Yerevan"
        ]
      },
      {
        "value": "Afghanistan Standard Time",
        "abbr": "AST",
        "offset": 4.5,
        "isdst": false,
        "text": "(UTC+04:30) Kabul",
        "utc": [
          "Asia/Kabul"
        ]
      },
      {
        "value": "West Asia Standard Time",
        "abbr": "WAST",
        "offset": 5,
        "isdst": false,
        "text": "(UTC+05:00) Ashgabat, Tashkent",
        "utc": [
          "Antarctica/Mawson",
          "Asia/Aqtau",
          "Asia/Aqtobe",
          "Asia/Ashgabat",
          "Asia/Dushanbe",
          "Asia/Oral",
          "Asia/Samarkand",
          "Asia/Tashkent",
          "Etc/GMT-5",
          "Indian/Kerguelen",
          "Indian/Maldives"
        ]
      },
      {
        "value": "Pakistan Standard Time",
        "abbr": "PST",
        "offset": 5,
        "isdst": false,
        "text": "(UTC+05:00) Islamabad, Karachi",
        "utc": [
          "Asia/Karachi"
        ]
      },
      {
        "value": "India Standard Time",
        "abbr": "IST",
        "offset": 5.5,
        "isdst": false,
        "text": "(UTC+05:30) Chennai, Kolkata, Mumbai, New Delhi",
        "utc": [
          "Asia/Kolkata"
        ]
      },
      {
        "value": "Sri Lanka Standard Time",
        "abbr": "SLST",
        "offset": 5.5,
        "isdst": false,
        "text": "(UTC+05:30) Sri Jayawardenepura",
        "utc": [
          "Asia/Colombo"
        ]
      },
      {
        "value": "Nepal Standard Time",
        "abbr": "NST",
        "offset": 5.75,
        "isdst": false,
        "text": "(UTC+05:45) Kathmandu",
        "utc": [
          "Asia/Katmandu"
        ]
      },
      {
        "value": "Central Asia Standard Time",
        "abbr": "CAST",
        "offset": 6,
        "isdst": false,
        "text": "(UTC+06:00) Astana",
        "utc": [
          "Antarctica/Vostok",
          "Asia/Almaty",
          "Asia/Bishkek",
          "Asia/Qyzylorda",
          "Asia/Urumqi",
          "Etc/GMT-6",
          "Indian/Chagos"
        ]
      },
      {
        "value": "Bangladesh Standard Time",
        "abbr": "BST",
        "offset": 6,
        "isdst": false,
        "text": "(UTC+06:00) Dhaka",
        "utc": [
          "Asia/Dhaka",
          "Asia/Thimphu"
        ]
      },
      {
        "value": "Ekaterinburg Standard Time",
        "abbr": "EST",
        "offset": 6,
        "isdst": false,
        "text": "(UTC+06:00) Ekaterinburg",
        "utc": [
          "Asia/Yekaterinburg"
        ]
      },
      {
        "value": "Myanmar Standard Time",
        "abbr": "MST",
        "offset": 6.5,
        "isdst": false,
        "text": "(UTC+06:30) Yangon (Rangoon)",
        "utc": [
          "Asia/Rangoon",
          "Indian/Cocos"
        ]
      },
      {
        "value": "SE Asia Standard Time",
        "abbr": "SAST",
        "offset": 7,
        "isdst": false,
        "text": "(UTC+07:00) Bangkok, Hanoi, Jakarta",
        "utc": [
          "Antarctica/Davis",
          "Asia/Bangkok",
          "Asia/Hovd",
          "Asia/Jakarta",
          "Asia/Phnom_Penh",
          "Asia/Pontianak",
          "Asia/Saigon",
          "Asia/Vientiane",
          "Etc/GMT-7",
          "Indian/Christmas"
        ]
      },
      {
        "value": "N. Central Asia Standard Time",
        "abbr": "NCAST",
        "offset": 7,
        "isdst": false,
        "text": "(UTC+07:00) Novosibirsk",
        "utc": [
          "Asia/Novokuznetsk",
          "Asia/Novosibirsk",
          "Asia/Omsk"
        ]
      },
      {
        "value": "China Standard Time",
        "abbr": "CST",
        "offset": 8,
        "isdst": false,
        "text": "(UTC+08:00) Beijing, Chongqing, Hong Kong, Urumqi",
        "utc": [
          "Asia/Hong_Kong",
          "Asia/Macau",
          "Asia/Shanghai"
        ]
      },
      {
        "value": "North Asia Standard Time",
        "abbr": "NAST",
        "offset": 8,
        "isdst": false,
        "text": "(UTC+08:00) Krasnoyarsk",
        "utc": [
          "Asia/Krasnoyarsk"
        ]
      },
      {
        "value": "Singapore Standard Time",
        "abbr": "MPST",
        "offset": 8,
        "isdst": false,
        "text": "(UTC+08:00) Kuala Lumpur, Singapore",
        "utc": [
          "Asia/Brunei",
          "Asia/Kuala_Lumpur",
          "Asia/Kuching",
          "Asia/Makassar",
          "Asia/Manila",
          "Asia/Singapore",
          "Etc/GMT-8"
        ]
      },
      {
        "value": "W. Australia Standard Time",
        "abbr": "WAST",
        "offset": 8,
        "isdst": false,
        "text": "(UTC+08:00) Perth",
        "utc": [
          "Antarctica/Casey",
          "Australia/Perth"
        ]
      },
      {
        "value": "Taipei Standard Time",
        "abbr": "TST",
        "offset": 8,
        "isdst": false,
        "text": "(UTC+08:00) Taipei",
        "utc": [
          "Asia/Taipei"
        ]
      },
      {
        "value": "Ulaanbaatar Standard Time",
        "abbr": "UST",
        "offset": 8,
        "isdst": false,
        "text": "(UTC+08:00) Ulaanbaatar",
        "utc": [
          "Asia/Choibalsan",
          "Asia/Ulaanbaatar"
        ]
      },
      {
        "value": "North Asia East Standard Time",
        "abbr": "NAEST",
        "offset": 9,
        "isdst": false,
        "text": "(UTC+09:00) Irkutsk",
        "utc": [
          "Asia/Irkutsk"
        ]
      },
      {
        "value": "Tokyo Standard Time",
        "abbr": "TST",
        "offset": 9,
        "isdst": false,
        "text": "(UTC+09:00) Osaka, Sapporo, Tokyo",
        "utc": [
          "Asia/Dili",
          "Asia/Jayapura",
          "Asia/Tokyo",
          "Etc/GMT-9",
          "Pacific/Palau"
        ]
      },
      {
        "value": "Korea Standard Time",
        "abbr": "KST",
        "offset": 9,
        "isdst": false,
        "text": "(UTC+09:00) Seoul",
        "utc": [
          "Asia/Pyongyang",
          "Asia/Seoul"
        ]
      },
      {
        "value": "Cen. Australia Standard Time",
        "abbr": "CAST",
        "offset": 9.5,
        "isdst": false,
        "text": "(UTC+09:30) Adelaide",
        "utc": [
          "Australia/Adelaide",
          "Australia/Broken_Hill"
        ]
      },
      {
        "value": "AUS Central Standard Time",
        "abbr": "ACST",
        "offset": 9.5,
        "isdst": false,
        "text": "(UTC+09:30) Darwin",
        "utc": [
          "Australia/Darwin"
        ]
      },
      {
        "value": "E. Australia Standard Time",
        "abbr": "EAST",
        "offset": 10,
        "isdst": false,
        "text": "(UTC+10:00) Brisbane",
        "utc": [
          "Australia/Brisbane",
          "Australia/Lindeman"
        ]
      },
      {
        "value": "AUS Eastern Standard Time",
        "abbr": "AEST",
        "offset": 10,
        "isdst": false,
        "text": "(UTC+10:00) Canberra, Melbourne, Sydney",
        "utc": [
          "Australia/Melbourne",
          "Australia/Sydney"
        ]
      },
      {
        "value": "West Pacific Standard Time",
        "abbr": "WPST",
        "offset": 10,
        "isdst": false,
        "text": "(UTC+10:00) Guam, Port Moresby",
        "utc": [
          "Antarctica/DumontDUrville",
          "Etc/GMT-10",
          "Pacific/Guam",
          "Pacific/Port_Moresby",
          "Pacific/Saipan",
          "Pacific/Truk"
        ]
      },
      {
        "value": "Tasmania Standard Time",
        "abbr": "TST",
        "offset": 10,
        "isdst": false,
        "text": "(UTC+10:00) Hobart",
        "utc": [
          "Australia/Currie",
          "Australia/Hobart"
        ]
      },
      {
        "value": "Yakutsk Standard Time",
        "abbr": "YST",
        "offset": 10,
        "isdst": false,
        "text": "(UTC+10:00) Yakutsk",
        "utc": [
          "Asia/Chita",
          "Asia/Khandyga",
          "Asia/Yakutsk"
        ]
      },
      {
        "value": "Central Pacific Standard Time",
        "abbr": "CPST",
        "offset": 11,
        "isdst": false,
        "text": "(UTC+11:00) Solomon Is., New Caledonia",
        "utc": [
          "Antarctica/Macquarie",
          "Etc/GMT-11",
          "Pacific/Efate",
          "Pacific/Guadalcanal",
          "Pacific/Kosrae",
          "Pacific/Noumea",
          "Pacific/Ponape"
        ]
      },
      {
        "value": "Vladivostok Standard Time",
        "abbr": "VST",
        "offset": 11,
        "isdst": false,
        "text": "(UTC+11:00) Vladivostok",
        "utc": [
          "Asia/Sakhalin",
          "Asia/Ust-Nera",
          "Asia/Vladivostok"
        ]
      },
      {
        "value": "New Zealand Standard Time",
        "abbr": "NZST",
        "offset": 12,
        "isdst": false,
        "text": "(UTC+12:00) Auckland, Wellington",
        "utc": [
          "Antarctica/McMurdo",
          "Pacific/Auckland"
        ]
      },
      {
        "value": "UTC+12",
        "abbr": "U",
        "offset": 12,
        "isdst": false,
        "text": "(UTC+12:00) Coordinated Universal Time+12",
        "utc": [
          "Etc/GMT-12",
          "Pacific/Funafuti",
          "Pacific/Kwajalein",
          "Pacific/Majuro",
          "Pacific/Nauru",
          "Pacific/Tarawa",
          "Pacific/Wake",
          "Pacific/Wallis"
        ]
      },
      {
        "value": "Fiji Standard Time",
        "abbr": "FST",
        "offset": 12,
        "isdst": false,
        "text": "(UTC+12:00) Fiji",
        "utc": [
          "Pacific/Fiji"
        ]
      },
      {
        "value": "Magadan Standard Time",
        "abbr": "MST",
        "offset": 12,
        "isdst": false,
        "text": "(UTC+12:00) Magadan",
        "utc": [
          "Asia/Anadyr",
          "Asia/Kamchatka",
          "Asia/Magadan",
          "Asia/Srednekolymsk"
        ]
      },
      {
        "value": "Kamchatka Standard Time",
        "abbr": "KDT",
        "offset": 13,
        "isdst": true,
        "text": "(UTC+12:00) Petropavlovsk-Kamchatsky - Old",
        "utc": [
          "Asia/Kamchatka"
        ]
      },
      {
        "value": "Tonga Standard Time",
        "abbr": "TST",
        "offset": 13,
        "isdst": false,
        "text": "(UTC+13:00) Nuku'alofa",
        "utc": [
          "Etc/GMT-13",
          "Pacific/Enderbury",
          "Pacific/Fakaofo",
          "Pacific/Tongatapu"
        ]
      },
      {
        "value": "Samoa Standard Time",
        "abbr": "SST",
        "offset": 13,
        "isdst": false,
        "text": "(UTC+13:00) Samoa",
        "utc": [
          "Pacific/Apia"
        ]
      }
    ]    
  end

  def business_type_list
    [
      { name: 'Manufacturer' },
      { name: 'Wholesaler/distributor' },
      { name: 'Retailer' },
      { name: 'Agent' },
      { name: 'Trading company' },
      { name: 'Subcontractor' },
      { name: 'Public sector institution' },
      { name: 'Non profit' },
      { name: 'Service provider' },
      { name: 'Association' }
    ]
  end

  def language_list
    [
      {name: 'English', code: 'EN'},
      {name: 'Estonian', code: 'ES'},
      {name: 'Spanish', code: 'SP'} 
    ]
  end

  def employees_list
    [
      { name: '1', value: 1 },
      { name: '2-10', value: 2 },
      { name: '11-50', value: 3 },
      { name: '51-200', value: 4 },
      { name: '201-500', value: 5 },
      { name: '501-1000', value: 6 },
      { name: '1001-5000', value: 7 },
      { name: '5001-10000', value: 8 },
      { name: '10000+', value: 9 }
    ]
  end

  def turnover_list
    [
      { name: 'Below 1M USD', value: 1 },
      { name: '1-2.5M USD', value: 2 },
      { name: '2.5-5M USD', value: 3 },
      { name: '5-10M USD', value: 4 },
      { name: '10-50M USD', value: 5 },
      { name: '50-100M USD', value: 6 },
      { name: '100-500M USD', value: 7 },
      { name: '500-1000M USD', value: 8 },
      { name: 'Above 1000M USD', value: 9 }
    ]
  end

  def currency_list
    [
      "AED": "United Arab Emirates Dirham",
      "AFN": "Afghan Afghani",
      "ALL": "Albanian Lek",
      "AMD": "Armenian Dram",
      "ANG": "Netherlands Antillean Guilder",
      "AOA": "Angolan Kwanza",
      "ARS": "Argentine Peso",
      "AUD": "Australian Dollar",
      "AWG": "Aruban Florin",
      "AZN": "Azerbaijani Manat",
      "BAM": "Bosnia-Herzegovina Convertible Mark",
      "BBD": "Barbadian Dollar",
      "BDT": "Bangladeshi Taka",
      "BGN": "Bulgarian Lev",
      "BHD": "Bahraini Dinar",
      "BIF": "Burundian Franc",
      "BMD": "Bermudan Dollar",
      "BND": "Brunei Dollar",
      "BOB": "Bolivian Boliviano",
      "BRL": "Brazilian Real",
      "BSD": "Bahamian Dollar",
      "BTC": "Bitcoin",
      "BTN": "Bhutanese Ngultrum",
      "BWP": "Botswanan Pula",
      "BYN": "Belarusian Ruble",
      "BZD": "Belize Dollar",
      "CAD": "Canadian Dollar",
      "CDF": "Congolese Franc",
      "CHF": "Swiss Franc",
      "CLF": "Chilean Unit of Account (UF)",
      "CLP": "Chilean Peso",
      "CNH": "Chinese Yuan (Offshore)",
      "CNY": "Chinese Yuan",
      "COP": "Colombian Peso",
      "CRC": "Costa Rican Colón",
      "CUC": "Cuban Convertible Peso",
      "CUP": "Cuban Peso",
      "CVE": "Cape Verdean Escudo",
      "CZK": "Czech Republic Koruna",
      "DJF": "Djiboutian Franc",
      "DKK": "Danish Krone",
      "DOP": "Dominican Peso",
      "DZD": "Algerian Dinar",
      "EGP": "Egyptian Pound",
      "ERN": "Eritrean Nakfa",
      "ETB": "Ethiopian Birr",
      "EUR": "Euro",
      "FJD": "Fijian Dollar",
      "FKP": "Falkland Islands Pound",
      "GBP": "British Pound Sterling",
      "GEL": "Georgian Lari",
      "GGP": "Guernsey Pound",
      "GHS": "Ghanaian Cedi",
      "GIP": "Gibraltar Pound",
      "GMD": "Gambian Dalasi",
      "GNF": "Guinean Franc",
      "GTQ": "Guatemalan Quetzal",
      "GYD": "Guyanaese Dollar",
      "HKD": "Hong Kong Dollar",
      "HNL": "Honduran Lempira",
      "HRK": "Croatian Kuna",
      "HTG": "Haitian Gourde",
      "HUF": "Hungarian Forint",
      "IDR": "Indonesian Rupiah",
      "ILS": "Israeli New Sheqel",
      "IMP": "Manx pound",
      "INR": "Indian Rupee",
      "IQD": "Iraqi Dinar",
      "IRR": "Iranian Rial",
      "ISK": "Icelandic Króna",
      "JEP": "Jersey Pound",
      "JMD": "Jamaican Dollar",
      "JOD": "Jordanian Dinar",
      "JPY": "Japanese Yen",
      "KES": "Kenyan Shilling",
      "KGS": "Kyrgystani Som",
      "KHR": "Cambodian Riel",
      "KMF": "Comorian Franc",
      "KPW": "North Korean Won",
      "KRW": "South Korean Won",
      "KWD": "Kuwaiti Dinar",
      "KYD": "Cayman Islands Dollar",
      "KZT": "Kazakhstani Tenge",
      "LAK": "Laotian Kip",
      "LBP": "Lebanese Pound",
      "LKR": "Sri Lankan Rupee",
      "LRD": "Liberian Dollar",
      "LSL": "Lesotho Loti",
      "LYD": "Libyan Dinar",
      "MAD": "Moroccan Dirham",
      "MDL": "Moldovan Leu",
      "MGA": "Malagasy Ariary",
      "MKD": "Macedonian Denar",
      "MMK": "Myanma Kyat",
      "MNT": "Mongolian Tugrik",
      "MOP": "Macanese Pataca",
      "MRO": "Mauritanian Ouguiya (pre-2018)",
      "MRU": "Mauritanian Ouguiya",
      "MUR": "Mauritian Rupee",
      "MVR": "Maldivian Rufiyaa",
      "MWK": "Malawian Kwacha",
      "MXN": "Mexican Peso",
      "MYR": "Malaysian Ringgit",
      "MZN": "Mozambican Metical",
      "NAD": "Namibian Dollar",
      "NGN": "Nigerian Naira",
      "NIO": "Nicaraguan Córdoba",
      "NOK": "Norwegian Krone",
      "NPR": "Nepalese Rupee",
      "NZD": "New Zealand Dollar",
      "OMR": "Omani Rial",
      "PAB": "Panamanian Balboa",
      "PEN": "Peruvian Nuevo Sol",
      "PGK": "Papua New Guinean Kina",
      "PHP": "Philippine Peso",
      "PKR": "Pakistani Rupee",
      "PLN": "Polish Zloty",
      "PYG": "Paraguayan Guarani",
      "QAR": "Qatari Rial",
      "RON": "Romanian Leu",
      "RSD": "Serbian Dinar",
      "RUB": "Russian Ruble",
      "RWF": "Rwandan Franc",
      "SAR": "Saudi Riyal",
      "SBD": "Solomon Islands Dollar",
      "SCR": "Seychellois Rupee",
      "SDG": "Sudanese Pound",
      "SEK": "Swedish Krona",
      "SGD": "Singapore Dollar",
      "SHP": "Saint Helena Pound",
      "SLL": "Sierra Leonean Leone",
      "SOS": "Somali Shilling",
      "SRD": "Surinamese Dollar",
      "SSP": "South Sudanese Pound",
      "STD": "São Tomé and Príncipe Dobra (pre-2018)",
      "STN": "São Tomé and Príncipe Dobra",
      "SVC": "Salvadoran Colón",
      "SYP": "Syrian Pound",
      "SZL": "Swazi Lilangeni",
      "THB": "Thai Baht",
      "TJS": "Tajikistani Somoni",
      "TMT": "Turkmenistani Manat",
      "TND": "Tunisian Dinar",
      "TOP": "Tongan Pa'anga",
      "TRY": "Turkish Lira",
      "TTD": "Trinidad and Tobago Dollar",
      "TWD": "New Taiwan Dollar",
      "TZS": "Tanzanian Shilling",
      "UAH": "Ukrainian Hryvnia",
      "UGX": "Ugandan Shilling",
      "USD": "United States Dollar",
      "UYU": "Uruguayan Peso",
      "UZS": "Uzbekistan Som",
      "VEF": "Venezuelan Bolívar Fuerte",
      "VND": "Vietnamese Dong",
      "VUV": "Vanuatu Vatu",
      "WST": "Samoan Tala",
      "XAF": "CFA Franc BEAC",
      "XAG": "Silver Ounce",
      "XAU": "Gold Ounce",
      "XCD": "East Caribbean Dollar",
      "XDR": "Special Drawing Rights",
      "XOF": "CFA Franc BCEAO",
      "XPD": "Palladium Ounce",
      "XPF": "CFP Franc",
      "XPT": "Platinum Ounce",
      "YER": "Yemeni Rial",
      "ZAR": "South African Rand",
      "ZMW": "Zambian Kwacha",
      "ZWL": "Zimbabwean Dollar"
    ]    
  end

  def remote_ip
    if request.remote_ip == '127.0.0.1'
      '104.156.218.100'
    else
      request.remote_ip
    end
  end

  def current_geo
    url = "http://api.ipstack.com/#{remote_ip}?access_key=#{ENV['COUNTRY_TOKEN']}"
    uri = URI(url)
    response = Net::HTTP.get(uri)
    return JSON.parse(response)  
  end

  def url_decode(s)
     s.gsub(/((?:%[0-9a-fA-F]{2})+)/n) do
       [$1.delete('%')].pack('H*')
     end
  end

  def error_message obj
    return '' if obj.errors.empty?

    messages = obj.errors.full_messages.map { |msg| content_tag(:li, msg) }.join
    html = <<-HTML
    <div class="alert alert-danger alert-dismissible show" role="alert">
      <button type="button" class="close" data-dismiss="alert">
        <span aria-hidden="true">&times;</span>
      </button>
      <h4>
       #{pluralize(obj.errors.count, "error")} must be fixed
      </h4>
      #{messages}
    </div>
    HTML

    html.html_safe
  end

  def difference bids, bid
    begin
      item_total      = Money.new(bid.item_total*100, bid.bid_currency).exchange_to(bid.request.preferred_currency)  
    rescue Exception => e
      item_total      = Money.new(bid.item_total*100, bid.request.preferred_currency)
    end
    
    expected_budget = Money.new(bid.request.expected_budget*100, bid.request.preferred_currency)
    min_difference  = Money.new(1000000000000000000000000000, bid.request.preferred_currency)
    nearest_total   = Money.new(0, bid.request.preferred_currency)

    bids.each do |b|
      begin
        b_item_total = Money.new(b.item_total*100, b.bid_currency).exchange_to(b.request.preferred_currency)  
      rescue Exception => e
        b_item_total = Money.new(b.item_total*100, b.request.preferred_currency)
      end
      
      unless b.item_total == 0
        b_difference = b_item_total - expected_budget
        if b_difference < min_difference
          min_difference  = b_difference
          nearest_total   = b_item_total
        end
      end

    end
    
    difference      = item_total - nearest_total
    percent         = number_to_percentage( (difference/item_total)*100, precision: 2).to_s
    unless difference == 0
      if item_total == 0
        "No quote"
      else
        sprintf("%+.2f #{bid.request.preferred_currency} <br>&nbsp;&nbsp;&nbsp;#{percent}", difference).html_safe
      end
    else
      "-----<br>-----".html_safe
    end
  end

  def current_company
    if Company.exists? session[:current_company_id]
      return Company.find session[:current_company_id]
    else
      session[:current_company_id] = nil
      return nil
    end
  end
  
end
