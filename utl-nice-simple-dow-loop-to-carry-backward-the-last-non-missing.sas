%let pgm=utl-nice-simple-dow-loop-to-carry-backward-the-last-non-missing;

Nice simple dow loop to carry backward the last non missing value

   Two Solutions
       1. SAS datastet DOW loop
       2. WPS datastep DOW loop

We want to carry backward the vale just befoe a missing value.

github
https://tinyurl.com/89wpu4bt
https://github.com/rogerjdeangelis/utl-nice-simple-dow-loop-to-carry-backward-the-last-non-missing

StackOverflow
https://tinyurl.com/2na2d9m2
https://stackoverflow.com/questions/75805129/i-need-to-reassign-values-before-missing-to-the-last-element-before-the-missing

Very elegantsolution by
https://stackoverflow.com/users/4044936/peterclemmensen

/*                   _
(_)_ __  _ __  _   _| |_
| | `_ \| `_ \| | | | __|
| | | | | |_) | |_| | |_
|_|_| |_| .__/ \__,_|\__|
        |_|
*/

data have;
   input end;
cards4;
1
2
4
5
.
4
8
6
.
1
2
3
.
;;;;;
run;quit;

/**************************************************************************************************************************/
/*                                                                                                                        */
/*  Up to 40 obs from last table WORK.HAVE total obs=13 05APR2023:13:55:03                                                */
/*                                                                                                                        */
/*                                                                                                                        */
/*   INPUT          |    OUTPUT                                                                                           */
/*                  |                                                                                                     */
/*  Obs    END      |    Obs    END                                                                                       */
/*                  |                                                                                                     */
/*    1     1       |      1     5                                                                                        */
/*    2     2       |      2     5                                                                                        */
/*    3     4       |      3     5                                                                                        */
/*    4     5       |      4     5                                                                                        */
/*    5     .       |      5     .                                                                                        */
/*    6     4       |      6     6                                                                                        */
/*    7     8       |      7     6                                                                                        */
/*    8     6       |      8     6                                                                                        */
/*    9     .       |      9     .                                                                                        */
/*   10     1       |     10     3                                                                                        */
/*   11     2       |     11     3                                                                                        */
/*   12     3       |     12     3                                                                                        */
/*   13     .       |     13     .                                                                                        */
/*                  |                                                                                                     */
/**************************************************************************************************************************/

/*                         _       _   _
 ___  __ _ ___   ___  ___ | |_   _| |_(_) ___  _ __
/ __|/ _` / __| / __|/ _ \| | | | | __| |/ _ \| `_ \
\__ \ (_| \__ \ \__ \ (_) | | |_| | |_| | (_) | | | |
|___/\__,_|___/ |___/\___/|_|\__,_|\__|_|\___/|_| |_|

*/

data want(drop = e);
   do _N_ = 1 by 1 until (end = .);
      set have;
      if end then e = end;
   end;

   do _N_ = 1 to _N_;
      set have;
      if end then end = e;
      output;
   end;
run;

/*                              _       _   _
__      ___ __  ___   ___  ___ | |_   _| |_(_) ___  _ __
\ \ /\ / / `_ \/ __| / __|/ _ \| | | | | __| |/ _ \| `_ \
 \ V  V /| |_) \__ \ \__ \ (_) | | |_| | |_| | (_) | | | |
  \_/\_/ | .__/|___/ |___/\___/|_|\__,_|\__|_|\___/|_| |_|
         |_|
*/

%let work=%sysfunc(pathname(work));

%utl_submit_wps64("

libname wrk '&work';

data wanr_wps(drop = e); ;
data want(drop = e);
   do _N_ = 1 by 1 until (end = .);
      set wrk.have;
      if end then e = end;
   end;

   do _N_ = 1 to _N_;
      set wrk.have;
      if end then end = e;
      output;
   end;
run;

proc print;
run;quit;
");

/*           _               _
  ___  _   _| |_ _ __  _   _| |_
 / _ \| | | | __| `_ \| | | | __|
| (_) | |_| | |_| |_) | |_| | |_
 \___/ \__,_|\__| .__/ \__,_|\__|
                |_|
*/

/**************************************************************************************************************************/
/*                                                                                                                        */
/*  The WPS System                                                                                                        */
/*                                                                                                                        */
/*  Obs    END                                                                                                            */
/*                                                                                                                        */
/*    1     5                                                                                                             */
/*    2     5                                                                                                             */
/*    3     5                                                                                                             */
/*    4     5                                                                                                             */
/*    5     .                                                                                                             */
/*    6     6                                                                                                             */
/*    7     6                                                                                                             */
/*    8     6                                                                                                             */
/*    9     .                                                                                                             */
/*   10     3                                                                                                             */
/*   11     3                                                                                                             */
/*   12     3                                                                                                             */
/*   13     .                                                                                                             */
/*                                                                                                                        */
/**************************************************************************************************************************/

/*              _
  ___ _ __   __| |
 / _ \ `_ \ / _` |
|  __/ | | | (_| |
 \___|_| |_|\__,_|

*/

