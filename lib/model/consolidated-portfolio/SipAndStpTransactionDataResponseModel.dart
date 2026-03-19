import 'dart:convert';
/// transaction_details : [{"TranDate":"16 Mar 2026","Applicant":"ABHA AGARWAL","SchemeName":"HDFC Small Cap Fund (G)","Amount":49998,"Type":"SIP","Nature":"Purchase","FolioNo":"10912770/63","Nav":123,"Units":406,"FCode":"","SCode":"","Product":""},{"TranDate":"16 Mar 2026","Applicant":"ABHA AGARWAL","SchemeName":"Kotak Smallcap Fund (G)","Amount":49998,"Type":"SIP","Nature":"Purchase","FolioNo":"8043196","Nav":226,"Units":221,"FCode":"","SCode":"","Product":""},{"TranDate":"09 Mar 2026","Applicant":"ABHA AGARWAL","SchemeName":"Kotak Nifty 200 Momentum 30 Index Fund Reg (G)","Amount":69996,"Type":"SIP","Nature":"Purchase","FolioNo":"8043196","Nav":14,"Units":5045,"FCode":"","SCode":"","Product":""},{"TranDate":"02 Mar 2026","Applicant":"ABHA AGARWAL","SchemeName":"Franklin India Small Cap Fund (G)","Amount":49998,"Type":"SIP","Nature":"Purchase","FolioNo":"20424508","Nav":158,"Units":317,"FCode":"","SCode":"","Product":""},{"TranDate":"23 Feb 2026","Applicant":"ABHA AGARWAL","SchemeName":"HSBC Midcap Fund Reg (G)","Amount":49997,"Type":"SIP","Nature":"Purchase","FolioNo":"3195714/47","Nav":401,"Units":125,"FCode":"","SCode":"","Product":""},{"TranDate":"16 Feb 2026","Applicant":"ABHA AGARWAL","SchemeName":"HDFC Small Cap Fund (G)","Amount":49998,"Type":"SIP","Nature":"Purchase","FolioNo":"10912770/63","Nav":134,"Units":373,"FCode":"","SCode":"","Product":""},{"TranDate":"16 Feb 2026","Applicant":"ABHA AGARWAL","SchemeName":"Kotak Smallcap Fund (G)","Amount":49998,"Type":"SIP","Nature":"Purchase","FolioNo":"8043196","Nav":245,"Units":204,"FCode":"","SCode":"","Product":""},{"TranDate":"10 Feb 2026","Applicant":"ABHA AGARWAL","SchemeName":"HDFC Small Cap Fund (G)","Amount":49998,"Type":"SIP","Nature":"Purchase","FolioNo":"10912770/63","Nav":138,"Units":362,"FCode":"","SCode":"","Product":""},{"TranDate":"10 Feb 2026","Applicant":"ABHA AGARWAL","SchemeName":"Kotak Smallcap Fund (G)","Amount":49997,"Type":"SIP","Nature":"Purchase","FolioNo":"8043196","Nav":248,"Units":201,"FCode":"","SCode":"","Product":""},{"TranDate":"09 Feb 2026","Applicant":"ABHA AGARWAL","SchemeName":"Kotak Nifty 200 Momentum 30 Index Fund Reg (G)","Amount":69997,"Type":"SIP","Nature":"Purchase","FolioNo":"8043196","Nav":15,"Units":4736,"FCode":"","SCode":"","Product":""},{"TranDate":"02 Feb 2026","Applicant":"ABHA AGARWAL","SchemeName":"Franklin India Small Cap Fund (G)","Amount":49997,"Type":"SIP","Nature":"Purchase","FolioNo":"20424508","Nav":156,"Units":320,"FCode":"","SCode":"","Product":""},{"TranDate":"02 Feb 2026","Applicant":"MUKESH JINDAL","SchemeName":"Kotak Arbitrage Fund (G)","Amount":1499925,"Type":"NRP","Nature":"Purchase","FolioNo":"11120361","Nav":39,"Units":38688,"FCode":"","SCode":"","Product":""},{"TranDate":"02 Feb 2026","Applicant":"MUKESH JINDAL","SchemeName":"Motilal Oswal Arbitrage Fund Reg (G)","Amount":3235935,"Type":"SWI","Nature":"Purchase","FolioNo":"9108468593","Nav":11,"Units":301665,"FCode":"","SCode":"","Product":""},{"TranDate":"02 Feb 2026","Applicant":"MUKESH JINDAL","SchemeName":"Motilal Oswal Arbitrage Fund Reg (G)","Amount":1393445,"Type":"SWI","Nature":"Purchase","FolioNo":"9108468593","Nav":11,"Units":129902,"FCode":"","SCode":"","Product":""},{"TranDate":"02 Feb 2026","Applicant":"MUKESH JINDAL","SchemeName":"Motilal Oswal Arbitrage Fund Reg (G)","Amount":1625686,"Type":"SWI","Nature":"Purchase","FolioNo":"9108468593","Nav":11,"Units":151552,"FCode":"","SCode":"","Product":""},{"TranDate":"02 Feb 2026","Applicant":"MUKESH JINDAL","SchemeName":"Motilal Oswal Arbitrage Fund Reg (G)","Amount":3744433,"Type":"SWI","Nature":"Purchase","FolioNo":"9108468593","Nav":11,"Units":349069,"FCode":"","SCode":"","Product":""},{"TranDate":"02 Feb 2026","Applicant":"MUKESH JINDAL","SchemeName":"Aditya Birla SL Gold Fund Reg (G)","Amount":1004144,"Type":"SWI","Nature":"Purchase","FolioNo":"1044268625","Nav":43,"Units":23617,"FCode":"","SCode":"","Product":""},{"TranDate":"02 Feb 2026","Applicant":"MUKESH JINDAL","SchemeName":"Aditya Birla SL Gold Fund Reg (G)","Amount":1002874,"Type":"SWI","Nature":"Purchase","FolioNo":"1044268625","Nav":43,"Units":23587,"FCode":"","SCode":"","Product":""},{"TranDate":"02 Feb 2026","Applicant":"MUKESH JINDAL","SchemeName":"Aditya Birla SL Gold Fund Reg (G)","Amount":4533565,"Type":"SWI","Nature":"Purchase","FolioNo":"1044268625","Nav":43,"Units":106625,"FCode":"","SCode":"","Product":""},{"TranDate":"02 Feb 2026","Applicant":"MUKESH JINDAL","SchemeName":"Aditya Birla SL Gold Fund Reg (G)","Amount":2517761,"Type":"SWI","Nature":"Purchase","FolioNo":"1044268625","Nav":43,"Units":59216,"FCode":"","SCode":"","Product":""},{"TranDate":"30 Jan 2026","Applicant":"MUKESH JINDAL","SchemeName":"Aditya Birla SL Money Manager Fund Reg (G)","Amount":1002924,"Type":"SWO","Nature":"Sell","FolioNo":"1044268625","Nav":383,"Units":2618,"FCode":"","SCode":"","Product":""},{"TranDate":"30 Jan 2026","Applicant":"MUKESH JINDAL","SchemeName":"Aditya Birla SL Money Manager Fund Reg (G)","Amount":4533792,"Type":"SWO","Nature":"Sell","FolioNo":"1044268625","Nav":383,"Units":11837,"FCode":"","SCode":"","Product":""},{"TranDate":"30 Jan 2026","Applicant":"MUKESH JINDAL","SchemeName":"Aditya Birla SL Money Manager Fund Reg (G)","Amount":1004194,"Type":"SWO","Nature":"Sell","FolioNo":"1044268625","Nav":383,"Units":2622,"FCode":"","SCode":"","Product":""},{"TranDate":"30 Jan 2026","Applicant":"MUKESH JINDAL","SchemeName":"Aditya Birla SL Money Manager Fund Reg (G)","Amount":2517886,"Type":"SWO","Nature":"Sell","FolioNo":"1044268625","Nav":383,"Units":6574,"FCode":"","SCode":"","Product":""},{"TranDate":"29 Jan 2026","Applicant":"MUKESH JINDAL","SchemeName":"Motilal Oswal Gold and Silver Passive FoF (G)","Amount":1393515,"Type":"SWO","Nature":"Sell","FolioNo":"9108468593","Nav":41,"Units":34074,"FCode":"","SCode":"","Product":""},{"TranDate":"29 Jan 2026","Applicant":"MUKESH JINDAL","SchemeName":"Motilal Oswal Gold and Silver Passive FoF (G)","Amount":1625767,"Type":"SWO","Nature":"Sell","FolioNo":"9108468593","Nav":41,"Units":39753,"FCode":"","SCode":"","Product":""},{"TranDate":"29 Jan 2026","Applicant":"MUKESH JINDAL","SchemeName":"Motilal Oswal Gold and Silver Passive FoF (G)","Amount":3236097,"Type":"SWO","Nature":"Sell","FolioNo":"9108468593","Nav":41,"Units":79129,"FCode":"","SCode":"","Product":""},{"TranDate":"29 Jan 2026","Applicant":"MUKESH JINDAL","SchemeName":"Motilal Oswal Gold and Silver Passive FoF (G)","Amount":3744620,"Type":"SWO","Nature":"Sell","FolioNo":"9108468593","Nav":41,"Units":91563,"FCode":"","SCode":"","Product":""},{"TranDate":"21 Jan 2026","Applicant":"ABHA AGARWAL","SchemeName":"HSBC Midcap Fund Reg (G)","Amount":49997,"Type":"SIP","Nature":"Purchase","FolioNo":"3195714/47","Nav":383,"Units":130,"FCode":"","SCode":"","Product":""},{"TranDate":"19 Jan 2026","Applicant":"MUKESH JINDAL","SchemeName":"Kotak Arbitrage Fund (G)","Amount":1499925,"Type":"NRP","Nature":"Purchase","FolioNo":"11120361","Nav":39,"Units":38777,"FCode":"","SCode":"","Product":""},{"TranDate":"07 Jan 2026","Applicant":"ABHA AGARWAL","SchemeName":"Kotak Nifty 200 Momentum 30 Index Fund Reg (G)","Amount":69996,"Type":"SIP","Nature":"Purchase","FolioNo":"8043196","Nav":15,"Units":4707,"FCode":"","SCode":"","Product":""},{"TranDate":"01 Jan 2026","Applicant":"ABHA AGARWAL","SchemeName":"Franklin India Small Cap Fund (G)","Amount":49998,"Type":"SIP","Nature":"Purchase","FolioNo":"20424508","Nav":164,"Units":304,"FCode":"","SCode":"","Product":""},{"TranDate":"01 Jan 2026","Applicant":"ABHA AGARWAL","SchemeName":"Motilal Oswal Nifty Microcap 250 Index Fund Reg (G)","Amount":99995,"Type":"SIP","Nature":"Purchase","FolioNo":"91010211722","Nav":16,"Units":6142,"FCode":"","SCode":"","Product":""},{"TranDate":"30 Dec 2025","Applicant":"MUKESH JINDAL","SchemeName":"Aditya Birla SL Money Manager Fund Reg (G)","Amount":999950,"Type":"NRP","Nature":"Purchase","FolioNo":"1044268625","Nav":382,"Units":2618,"FCode":"","SCode":"","Product":""},{"TranDate":"22 Dec 2025","Applicant":"ABHA AGARWAL","SchemeName":"HSBC Midcap Fund Reg (G)","Amount":49998,"Type":"SIP","Nature":"Purchase","FolioNo":"3195714/47","Nav":407,"Units":123,"FCode":"","SCode":"","Product":""},{"TranDate":"22 Dec 2025","Applicant":"ABHA AGARWAL","SchemeName":"Motilal Oswal Nifty Microcap 250 Index Fund Reg (G)","Amount":99995,"Type":"SIP","Nature":"Purchase","FolioNo":"91010211722","Nav":16,"Units":6125,"FCode":"","SCode":"","Product":""},{"TranDate":"22 Dec 2025","Applicant":"MUKESH JINDAL","SchemeName":"Aditya Birla SL Money Manager Fund Reg (G)","Amount":999950,"Type":"NRP","Nature":"Purchase","FolioNo":"1044268625","Nav":381,"Units":2622,"FCode":"","SCode":"","Product":""},{"TranDate":"17 Dec 2025","Applicant":"MUKESH JINDAL","SchemeName":"DSP Nifty Next 50 Index Fund Reg (G)","Amount":7599620,"Type":"NRP","Nature":"Purchase","FolioNo":"2792302/14","Nav":26,"Units":288990,"FCode":"","SCode":"","Product":""},{"TranDate":"12 Dec 2025","Applicant":"MUKESH JINDAL","SchemeName":"Motilal Oswal Nifty Microcap 250 Index Fund Reg (G)","Amount":3499825,"Type":"NRP","Nature":"Purchase","FolioNo":"91036721646","Nav":16,"Units":217014,"FCode":"","SCode":"","Product":""},{"TranDate":"08 Dec 2025","Applicant":"ABHA AGARWAL","SchemeName":"Kotak Nifty 200 Momentum 30 Index Fund Reg (G)","Amount":69996,"Type":"SIP","Nature":"Purchase","FolioNo":"8043196","Nav":15,"Units":4727,"FCode":"","SCode":"","Product":""},{"TranDate":"01 Dec 2025","Applicant":"ABHA AGARWAL","SchemeName":"Franklin India Small Cap Fund (G)","Amount":49998,"Type":"SIP","Nature":"Purchase","FolioNo":"20424508","Nav":168,"Units":297,"FCode":"","SCode":"","Product":""},{"TranDate":"28 Nov 2025","Applicant":"MUKESH JINDAL","SchemeName":"Aditya Birla SL Money Manager Fund Reg (G)","Amount":2499875,"Type":"NRP","Nature":"Purchase","FolioNo":"1044268625","Nav":380,"Units":6574,"FCode":"","SCode":"","Product":""},{"TranDate":"26 Nov 2025","Applicant":"MUKESH JINDAL","SchemeName":"Aditya Birla SL Money Manager Fund Reg (G)","Amount":4499775,"Type":"NRP","Nature":"Purchase","FolioNo":"1044268625","Nav":380,"Units":11837,"FCode":"","SCode":"","Product":""},{"TranDate":"21 Nov 2025","Applicant":"ABHA AGARWAL","SchemeName":"HSBC Midcap Fund Reg (G)","Amount":49997,"Type":"SIP","Nature":"Purchase","FolioNo":"3195714/47","Nav":405,"Units":123,"FCode":"","SCode":"","Product":""},{"TranDate":"07 Nov 2025","Applicant":"ABHA AGARWAL","SchemeName":"Kotak Nifty 200 Momentum 30 Index Fund Reg (G)","Amount":69996,"Type":"SIP","Nature":"Purchase","FolioNo":"8043196","Nav":15,"Units":4721,"FCode":"","SCode":"","Product":""},{"TranDate":"04 Nov 2025","Applicant":"MUKESH JINDAL","SchemeName":"Motilal Oswal Nifty Microcap 250 Index Fund Reg (G)","Amount":112742,"Type":"SWI","Nature":"Purchase","FolioNo":"910147185246","Nav":17,"Units":6549,"FCode":"","SCode":"","Product":""},{"TranDate":"04 Nov 2025","Applicant":"MUKESH JINDAL","SchemeName":"Motilal Oswal Nifty Microcap 250 Index Fund Reg (G)","Amount":124895,"Type":"SWI","Nature":"Purchase","FolioNo":"910147185246","Nav":17,"Units":7255,"FCode":"","SCode":"","Product":""},{"TranDate":"04 Nov 2025","Applicant":"MUKESH JINDAL","SchemeName":"Motilal Oswal Nifty Microcap 250 Index Fund Reg (G)","Amount":116989,"Type":"SWI","Nature":"Purchase","FolioNo":"910147185246","Nav":17,"Units":6796,"FCode":"","SCode":"","Product":""},{"TranDate":"04 Nov 2025","Applicant":"MUKESH JINDAL","SchemeName":"Motilal Oswal Nifty Microcap 250 Index Fund Reg (G)","Amount":113746,"Type":"SWI","Nature":"Purchase","FolioNo":"910147185246","Nav":17,"Units":6607,"FCode":"","SCode":"","Product":""},{"TranDate":"04 Nov 2025","Applicant":"MUKESH JINDAL","SchemeName":"Motilal Oswal Nifty Microcap 250 Index Fund Reg (G)","Amount":100419,"Type":"SWI","Nature":"Purchase","FolioNo":"910147185246","Nav":17,"Units":5833,"FCode":"","SCode":"","Product":""},{"TranDate":"04 Nov 2025","Applicant":"MUKESH JINDAL","SchemeName":"Motilal Oswal Nifty Microcap 250 Index Fund Reg (G)","Amount":95636,"Type":"SWI","Nature":"Purchase","FolioNo":"910147185246","Nav":17,"Units":5555,"FCode":"","SCode":"","Product":""},{"TranDate":"04 Nov 2025","Applicant":"MUKESH JINDAL","SchemeName":"Motilal Oswal Nifty Microcap 250 Index Fund Reg (G)","Amount":100922,"Type":"SWI","Nature":"Purchase","FolioNo":"910147185246","Nav":17,"Units":5862,"FCode":"","SCode":"","Product":""},{"TranDate":"04 Nov 2025","Applicant":"MUKESH JINDAL","SchemeName":"Motilal Oswal Nifty Microcap 250 Index Fund Reg (G)","Amount":92851,"Type":"SWI","Nature":"Purchase","FolioNo":"910147185246","Nav":17,"Units":5393,"FCode":"","SCode":"","Product":""},{"TranDate":"04 Nov 2025","Applicant":"MUKESH JINDAL","SchemeName":"Motilal Oswal Nifty Microcap 250 Index Fund Reg (G)","Amount":112045,"Type":"SWI","Nature":"Purchase","FolioNo":"910147185246","Nav":17,"Units":6508,"FCode":"","SCode":"","Product":""},{"TranDate":"04 Nov 2025","Applicant":"MUKESH JINDAL","SchemeName":"Motilal Oswal Nifty Microcap 250 Index Fund Reg (G)","Amount":100366,"Type":"SWI","Nature":"Purchase","FolioNo":"910147185246","Nav":17,"Units":5830,"FCode":"","SCode":"","Product":""},{"TranDate":"04 Nov 2025","Applicant":"MUKESH JINDAL","SchemeName":"Motilal Oswal Nifty Microcap 250 Index Fund Reg (G)","Amount":100600,"Type":"SWI","Nature":"Purchase","FolioNo":"910147185246","Nav":17,"Units":5844,"FCode":"","SCode":"","Product":""},{"TranDate":"04 Nov 2025","Applicant":"MUKESH JINDAL","SchemeName":"Motilal Oswal Nifty Microcap 250 Index Fund Reg (G)","Amount":99026,"Type":"SWI","Nature":"Purchase","FolioNo":"910147185246","Nav":17,"Units":5752,"FCode":"","SCode":"","Product":""},{"TranDate":"04 Nov 2025","Applicant":"MUKESH JINDAL","SchemeName":"Motilal Oswal Nifty Microcap 250 Index Fund Reg (G)","Amount":99456,"Type":"SWI","Nature":"Purchase","FolioNo":"910147185246","Nav":17,"Units":5777,"FCode":"","SCode":"","Product":""},{"TranDate":"04 Nov 2025","Applicant":"MUKESH JINDAL","SchemeName":"Motilal Oswal Nifty Microcap 250 Index Fund Reg (G)","Amount":1311841,"Type":"SWI","Nature":"Purchase","FolioNo":"910147185246","Nav":17,"Units":76201,"FCode":"","SCode":"","Product":""},{"TranDate":"04 Nov 2025","Applicant":"MUKESH JINDAL","SchemeName":"Motilal Oswal Nifty Microcap 250 Index Fund Reg (G)","Amount":131184,"Type":"SWI","Nature":"Purchase","FolioNo":"910147185246","Nav":17,"Units":7620,"FCode":"","SCode":"","Product":""},{"TranDate":"04 Nov 2025","Applicant":"MUKESH JINDAL","SchemeName":"Motilal Oswal Nifty Microcap 250 Index Fund Reg (G)","Amount":147606,"Type":"SWI","Nature":"Purchase","FolioNo":"910147185246","Nav":17,"Units":8574,"FCode":"","SCode":"","Product":""},{"TranDate":"04 Nov 2025","Applicant":"MUKESH JINDAL","SchemeName":"Motilal Oswal Nifty Microcap 250 Index Fund Reg (G)","Amount":91025,"Type":"SWI","Nature":"Purchase","FolioNo":"910147185246","Nav":17,"Units":5287,"FCode":"","SCode":"","Product":""},{"TranDate":"04 Nov 2025","Applicant":"MUKESH JINDAL","SchemeName":"Motilal Oswal Nifty Microcap 250 Index Fund Reg (G)","Amount":99964,"Type":"SWI","Nature":"Purchase","FolioNo":"910147185246","Nav":17,"Units":5807,"FCode":"","SCode":"","Product":""},{"TranDate":"04 Nov 2025","Applicant":"MUKESH JINDAL","SchemeName":"Motilal Oswal Nifty Microcap 250 Index Fund Reg (G)","Amount":144849,"Type":"SWI","Nature":"Purchase","FolioNo":"910147185246","Nav":17,"Units":8414,"FCode":"","SCode":"","Product":""},{"TranDate":"04 Nov 2025","Applicant":"MUKESH JINDAL","SchemeName":"Motilal Oswal Nifty Microcap 250 Index Fund Reg (G)","Amount":123733,"Type":"SWI","Nature":"Purchase","FolioNo":"910147185246","Nav":17,"Units":7187,"FCode":"","SCode":"","Product":""},{"TranDate":"04 Nov 2025","Applicant":"MUKESH JINDAL","SchemeName":"Motilal Oswal Nifty Microcap 250 Index Fund Reg (G)","Amount":96397,"Type":"SWI","Nature":"Purchase","FolioNo":"910147185246","Nav":17,"Units":5599,"FCode":"","SCode":"","Product":""},{"TranDate":"04 Nov 2025","Applicant":"MUKESH JINDAL","SchemeName":"Motilal Oswal Nifty Microcap 250 Index Fund Reg (G)","Amount":94031,"Type":"SWI","Nature":"Purchase","FolioNo":"910147185246","Nav":17,"Units":5462,"FCode":"","SCode":"","Product":""},{"TranDate":"04 Nov 2025","Applicant":"MUKESH JINDAL","SchemeName":"Motilal Oswal Nifty Microcap 250 Index Fund Reg (G)","Amount":109118,"Type":"SWI","Nature":"Purchase","FolioNo":"910147185246","Nav":17,"Units":6338,"FCode":"","SCode":"","Product":""},{"TranDate":"04 Nov 2025","Applicant":"MUKESH JINDAL","SchemeName":"Motilal Oswal Nifty Microcap 250 Index Fund Reg (G)","Amount":118251,"Type":"SWI","Nature":"Purchase","FolioNo":"910147185246","Nav":17,"Units":6869,"FCode":"","SCode":"","Product":""},{"TranDate":"04 Nov 2025","Applicant":"MUKESH JINDAL","SchemeName":"Motilal Oswal Nifty Microcap 250 Index Fund Reg (G)","Amount":111499,"Type":"SWI","Nature":"Purchase","FolioNo":"910147185246","Nav":17,"Units":6477,"FCode":"","SCode":"","Product":""},{"TranDate":"04 Nov 2025","Applicant":"MUKESH JINDAL","SchemeName":"Motilal Oswal Nifty Microcap 250 Index Fund Reg (G)","Amount":110451,"Type":"SWI","Nature":"Purchase","FolioNo":"910147185246","Nav":17,"Units":6416,"FCode":"","SCode":"","Product":""},{"TranDate":"04 Nov 2025","Applicant":"MUKESH JINDAL","SchemeName":"Motilal Oswal Nifty Microcap 250 Index Fund Reg (G)","Amount":101897,"Type":"SWI","Nature":"Purchase","FolioNo":"910147185246","Nav":17,"Units":5919,"FCode":"","SCode":"","Product":""},{"TranDate":"03 Nov 2025","Applicant":"ABHA AGARWAL","SchemeName":"Franklin India Small Cap Fund (G)","Amount":49998,"Type":"SIP","Nature":"Purchase","FolioNo":"20424508","Nav":173,"Units":289,"FCode":"","SCode":"","Product":""},{"TranDate":"","Applicant":"","SchemeName":"Total","Amount":28559368,"Type":"","Nature":"","FolioNo":"","Nav":0,"Units":0,"FCode":"","SCode":"","Product":""}]
/// sip_stp_details : [{"TranDate":"16 Mar 2026","Applicant":"ABHA AGARWAL","SchemeName":"HDFC Small Cap Fund (G)","Amount":49998,"Type":"SIP","Nature":"Purchase","FolioNo":"10912770/63","Nav":123,"Units":406,"FCode":"","SCode":"","Product":""},{"TranDate":"16 Mar 2026","Applicant":"ABHA AGARWAL","SchemeName":"Kotak Smallcap Fund (G)","Amount":49998,"Type":"SIP","Nature":"Purchase","FolioNo":"8043196","Nav":226,"Units":221,"FCode":"","SCode":"","Product":""},{"TranDate":"09 Mar 2026","Applicant":"ABHA AGARWAL","SchemeName":"Kotak Nifty 200 Momentum 30 Index Fund Reg (G)","Amount":69996,"Type":"SIP","Nature":"Purchase","FolioNo":"8043196","Nav":14,"Units":5045,"FCode":"","SCode":"","Product":""},{"TranDate":"02 Mar 2026","Applicant":"ABHA AGARWAL","SchemeName":"Franklin India Small Cap Fund (G)","Amount":49998,"Type":"SIP","Nature":"Purchase","FolioNo":"20424508","Nav":158,"Units":317,"FCode":"","SCode":"","Product":""},{"TranDate":"23 Feb 2026","Applicant":"ABHA AGARWAL","SchemeName":"HSBC Midcap Fund Reg (G)","Amount":49997,"Type":"SIP","Nature":"Purchase","FolioNo":"3195714/47","Nav":401,"Units":125,"FCode":"","SCode":"","Product":""},{"TranDate":"16 Feb 2026","Applicant":"ABHA AGARWAL","SchemeName":"HDFC Small Cap Fund (G)","Amount":49998,"Type":"SIP","Nature":"Purchase","FolioNo":"10912770/63","Nav":134,"Units":373,"FCode":"","SCode":"","Product":""},{"TranDate":"16 Feb 2026","Applicant":"ABHA AGARWAL","SchemeName":"Kotak Smallcap Fund (G)","Amount":49998,"Type":"SIP","Nature":"Purchase","FolioNo":"8043196","Nav":245,"Units":204,"FCode":"","SCode":"","Product":""},{"TranDate":"10 Feb 2026","Applicant":"ABHA AGARWAL","SchemeName":"HDFC Small Cap Fund (G)","Amount":49998,"Type":"SIP","Nature":"Purchase","FolioNo":"10912770/63","Nav":138,"Units":362,"FCode":"","SCode":"","Product":""},{"TranDate":"10 Feb 2026","Applicant":"ABHA AGARWAL","SchemeName":"Kotak Smallcap Fund (G)","Amount":49997,"Type":"SIP","Nature":"Purchase","FolioNo":"8043196","Nav":248,"Units":201,"FCode":"","SCode":"","Product":""},{"TranDate":"09 Feb 2026","Applicant":"ABHA AGARWAL","SchemeName":"Kotak Nifty 200 Momentum 30 Index Fund Reg (G)","Amount":69997,"Type":"SIP","Nature":"Purchase","FolioNo":"8043196","Nav":15,"Units":4736,"FCode":"","SCode":"","Product":""},{"TranDate":"02 Feb 2026","Applicant":"ABHA AGARWAL","SchemeName":"Franklin India Small Cap Fund (G)","Amount":49997,"Type":"SIP","Nature":"Purchase","FolioNo":"20424508","Nav":156,"Units":320,"FCode":"","SCode":"","Product":""},{"TranDate":"21 Jan 2026","Applicant":"ABHA AGARWAL","SchemeName":"HSBC Midcap Fund Reg (G)","Amount":49997,"Type":"SIP","Nature":"Purchase","FolioNo":"3195714/47","Nav":383,"Units":130,"FCode":"","SCode":"","Product":""},{"TranDate":"07 Jan 2026","Applicant":"ABHA AGARWAL","SchemeName":"Kotak Nifty 200 Momentum 30 Index Fund Reg (G)","Amount":69996,"Type":"SIP","Nature":"Purchase","FolioNo":"8043196","Nav":15,"Units":4707,"FCode":"","SCode":"","Product":""},{"TranDate":"01 Jan 2026","Applicant":"ABHA AGARWAL","SchemeName":"Franklin India Small Cap Fund (G)","Amount":49998,"Type":"SIP","Nature":"Purchase","FolioNo":"20424508","Nav":164,"Units":304,"FCode":"","SCode":"","Product":""},{"TranDate":"01 Jan 2026","Applicant":"ABHA AGARWAL","SchemeName":"Motilal Oswal Nifty Microcap 250 Index Fund Reg (G)","Amount":99995,"Type":"SIP","Nature":"Purchase","FolioNo":"91010211722","Nav":16,"Units":6142,"FCode":"","SCode":"","Product":""},{"TranDate":"22 Dec 2025","Applicant":"ABHA AGARWAL","SchemeName":"HSBC Midcap Fund Reg (G)","Amount":49998,"Type":"SIP","Nature":"Purchase","FolioNo":"3195714/47","Nav":407,"Units":123,"FCode":"","SCode":"","Product":""},{"TranDate":"22 Dec 2025","Applicant":"ABHA AGARWAL","SchemeName":"Motilal Oswal Nifty Microcap 250 Index Fund Reg (G)","Amount":99995,"Type":"SIP","Nature":"Purchase","FolioNo":"91010211722","Nav":16,"Units":6125,"FCode":"","SCode":"","Product":""},{"TranDate":"08 Dec 2025","Applicant":"ABHA AGARWAL","SchemeName":"Kotak Nifty 200 Momentum 30 Index Fund Reg (G)","Amount":69996,"Type":"SIP","Nature":"Purchase","FolioNo":"8043196","Nav":15,"Units":4727,"FCode":"","SCode":"","Product":""},{"TranDate":"01 Dec 2025","Applicant":"ABHA AGARWAL","SchemeName":"Franklin India Small Cap Fund (G)","Amount":49998,"Type":"SIP","Nature":"Purchase","FolioNo":"20424508","Nav":168,"Units":297,"FCode":"","SCode":"","Product":""},{"TranDate":"21 Nov 2025","Applicant":"ABHA AGARWAL","SchemeName":"HSBC Midcap Fund Reg (G)","Amount":49997,"Type":"SIP","Nature":"Purchase","FolioNo":"3195714/47","Nav":405,"Units":123,"FCode":"","SCode":"","Product":""},{"TranDate":"07 Nov 2025","Applicant":"ABHA AGARWAL","SchemeName":"Kotak Nifty 200 Momentum 30 Index Fund Reg (G)","Amount":69996,"Type":"SIP","Nature":"Purchase","FolioNo":"8043196","Nav":15,"Units":4721,"FCode":"","SCode":"","Product":""},{"TranDate":"03 Nov 2025","Applicant":"ABHA AGARWAL","SchemeName":"Franklin India Small Cap Fund (G)","Amount":49998,"Type":"SIP","Nature":"Purchase","FolioNo":"20424508","Nav":173,"Units":289,"FCode":"","SCode":"","Product":""},{"TranDate":"","Applicant":"","SchemeName":"Total","Amount":1299936,"Type":"","Nature":"","FolioNo":"","Nav":0,"Units":0,"FCode":"","SCode":"","Product":""}]
/// sip : [{"TranDate":"03 Nov 2025","Applicant":"ABHA AGARWAL","SchemeName":"Franklin India Small Cap Fund (G)","Amount":49998,"Type":"SIP","Nature":"Purchase","FolioNo":"20424508","Nav":173,"Units":289,"FCode":"","SCode":"","Product":""}]
/// stp_details : [{"TranDate":"03 Nov 2025","Applicant":"ABHA AGARWAL","SchemeName":"Franklin India Small Cap Fund (G)","Amount":49998,"Type":"SIP","Nature":"Purchase","FolioNo":"20424508","Nav":173,"Units":289,"FCode":"","SCode":"","Product":""}]
/// swp_details : [{"TranDate":"03 Nov 2025","Applicant":"ABHA AGARWAL","SchemeName":"Franklin India Small Cap Fund (G)","Amount":49998,"Type":"SIP","Nature":"Purchase","FolioNo":"20424508","Nav":173,"Units":289,"FCode":"","SCode":"","Product":""}]
/// success : 1
/// message : ""

SipAndStpTransactionDataResponseModel sipAndStpTransactionDataResponseModelFromJson(String str) => SipAndStpTransactionDataResponseModel.fromJson(json.decode(str));
String sipAndStpTransactionDataResponseModelToJson(SipAndStpTransactionDataResponseModel data) => json.encode(data.toJson());
class SipAndStpTransactionDataResponseModel {
  SipAndStpTransactionDataResponseModel({
      List<TransactionDetails>? transactionDetails, 
      List<TransactionDetails>? sipStpDetails,
      List<TransactionDetails>? sip,
      List<TransactionDetails>? stpDetails,
      List<TransactionDetails>? swpDetails,
      num? success, 
      String? message,}){
    _transactionDetails = transactionDetails;
    _sipStpDetails = sipStpDetails;
    _sip = sip;
    _stpDetails = stpDetails;
    _swpDetails = swpDetails;
    _success = success;
    _message = message;
}

  SipAndStpTransactionDataResponseModel.fromJson(dynamic json) {
    if (json['transaction_details'] != null) {
      _transactionDetails = [];
      json['transaction_details'].forEach((v) {
        _transactionDetails?.add(TransactionDetails.fromJson(v));
      });
    }
    if (json['sip_stp_details'] != null) {
      _sipStpDetails = [];
      json['sip_stp_details'].forEach((v) {
        _sipStpDetails?.add(TransactionDetails.fromJson(v));
      });
    }
    if (json['sip'] != null) {
      _sip = [];
      json['sip'].forEach((v) {
        _sip?.add(TransactionDetails.fromJson(v));
      });
    }
    if (json['stp_details'] != null) {
      _stpDetails = [];
      json['stp_details'].forEach((v) {
        _stpDetails?.add(TransactionDetails.fromJson(v));
      });
    }
    if (json['swp_details'] != null) {
      _swpDetails = [];
      json['swp_details'].forEach((v) {
        _swpDetails?.add(TransactionDetails.fromJson(v));
      });
    }
    _success = json['success'];
    _message = json['message'];
  }
  List<TransactionDetails>? _transactionDetails;
  List<TransactionDetails>? _sipStpDetails;
  List<TransactionDetails>? _sip;
  List<TransactionDetails>? _stpDetails;
  List<TransactionDetails>? _swpDetails;
  num? _success;
  String? _message;
SipAndStpTransactionDataResponseModel copyWith({  List<TransactionDetails>? transactionDetails,
  List<TransactionDetails>? sipStpDetails,
  List<TransactionDetails>? sip,
  List<TransactionDetails>? stpDetails,
  List<TransactionDetails>? swpDetails,
  num? success,
  String? message,
}) => SipAndStpTransactionDataResponseModel(  transactionDetails: transactionDetails ?? _transactionDetails,
  sipStpDetails: sipStpDetails ?? _sipStpDetails,
  sip: sip ?? _sip,
  stpDetails: stpDetails ?? _stpDetails,
  swpDetails: swpDetails ?? _swpDetails,
  success: success ?? _success,
  message: message ?? _message,
);
  List<TransactionDetails>? get transactionDetails => _transactionDetails;
  List<TransactionDetails>? get sipStpDetails => _sipStpDetails;
  List<TransactionDetails>? get sip => _sip;
  List<TransactionDetails>? get stpDetails => _stpDetails;
  List<TransactionDetails>? get swpDetails => _swpDetails;
  num? get success => _success;
  String? get message => _message;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_transactionDetails != null) {
      map['transaction_details'] = _transactionDetails?.map((v) => v.toJson()).toList();
    }
    if (_sipStpDetails != null) {
      map['sip_stp_details'] = _sipStpDetails?.map((v) => v.toJson()).toList();
    }
    if (_sip != null) {
      map['sip'] = _sip?.map((v) => v.toJson()).toList();
    }
    if (_stpDetails != null) {
      map['stp_details'] = _stpDetails?.map((v) => v.toJson()).toList();
    }
    if (_swpDetails != null) {
      map['swp_details'] = _swpDetails?.map((v) => v.toJson()).toList();
    }
    map['success'] = _success;
    map['message'] = _message;
    return map;
  }

}

/// TranDate : "16 Mar 2026"
/// Applicant : "ABHA AGARWAL"
/// SchemeName : "HDFC Small Cap Fund (G)"
/// Amount : 49998
/// Type : "SIP"
/// Nature : "Purchase"
/// FolioNo : "10912770/63"
/// Nav : 123
/// Units : 406
/// FCode : ""
/// SCode : ""
/// Product : ""

TransactionDetails transactionDetailsFromJson(String str) => TransactionDetails.fromJson(json.decode(str));
String transactionDetailsToJson(TransactionDetails data) => json.encode(data.toJson());
class TransactionDetails {
  TransactionDetails({
      String? tranDate, 
      String? applicant, 
      String? schemeName, 
      num? amount, 
      String? type, 
      String? nature, 
      String? folioNo, 
      num? nav, 
      num? units, 
      String? fCode, 
      String? sCode, 
      String? product,}){
    _tranDate = tranDate;
    _applicant = applicant;
    _schemeName = schemeName;
    _amount = amount;
    _type = type;
    _nature = nature;
    _folioNo = folioNo;
    _nav = nav;
    _units = units;
    _fCode = fCode;
    _sCode = sCode;
    _product = product;
}

  TransactionDetails.fromJson(dynamic json) {
    _tranDate = json['TranDate'];
    _applicant = json['Applicant'];
    _schemeName = json['SchemeName'];
    _amount = json['Amount'];
    _type = json['Type'];
    _nature = json['Nature'];
    _folioNo = json['FolioNo'];
    _nav = json['Nav'];
    _units = json['Units'];
    _fCode = json['FCode'];
    _sCode = json['SCode'];
    _product = json['Product'];
  }
  String? _tranDate;
  String? _applicant;
  String? _schemeName;
  num? _amount;
  String? _type;
  String? _nature;
  String? _folioNo;
  num? _nav;
  num? _units;
  String? _fCode;
  String? _sCode;
  String? _product;
TransactionDetails copyWith({  String? tranDate,
  String? applicant,
  String? schemeName,
  num? amount,
  String? type,
  String? nature,
  String? folioNo,
  num? nav,
  num? units,
  String? fCode,
  String? sCode,
  String? product,
}) => TransactionDetails(  tranDate: tranDate ?? _tranDate,
  applicant: applicant ?? _applicant,
  schemeName: schemeName ?? _schemeName,
  amount: amount ?? _amount,
  type: type ?? _type,
  nature: nature ?? _nature,
  folioNo: folioNo ?? _folioNo,
  nav: nav ?? _nav,
  units: units ?? _units,
  fCode: fCode ?? _fCode,
  sCode: sCode ?? _sCode,
  product: product ?? _product,
);
  String? get tranDate => _tranDate;
  String? get applicant => _applicant;
  String? get schemeName => _schemeName;
  num? get amount => _amount;
  String? get type => _type;
  String? get nature => _nature;
  String? get folioNo => _folioNo;
  num? get nav => _nav;
  num? get units => _units;
  String? get fCode => _fCode;
  String? get sCode => _sCode;
  String? get product => _product;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['TranDate'] = _tranDate;
    map['Applicant'] = _applicant;
    map['SchemeName'] = _schemeName;
    map['Amount'] = _amount;
    map['Type'] = _type;
    map['Nature'] = _nature;
    map['FolioNo'] = _folioNo;
    map['Nav'] = _nav;
    map['Units'] = _units;
    map['FCode'] = _fCode;
    map['SCode'] = _sCode;
    map['Product'] = _product;
    return map;
  }
}