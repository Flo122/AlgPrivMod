#include <macro.h>
/*
	Master Life Configuration File
	This file is to setup variables for the client, there are still other configuration files in the system

*****************************
****** Backend Variables *****
*****************************
*/

//////////////////////////////////
//Gambling config
//////////////////////////////////
EVGA_Gamble_roll_time                               = 5; //the duration of one gamble (how long the dice rolls) only animation stuff but don´t try 0... ;o)
EVGA_Gamble_max_bet                                 = 5000000; //Dollar
EVGA_Gamble_send_watched_illegal_gambling_to_chat   = 1;  //wenn der Spieler erwischt wurde kann eine Nachricht an alle gesendet werden. Toll? Keine Ahnung ;o)    0=nicht senden, 1=senden
EVGA_Gamble_watched_illegal_gambling_percent        = 5;  //Die Wahrscheinlichkeit ob ein Spieler beim illegalen Casino beobachtet wird oder nicht [0...100%] 0%=never, 100%=everytime  --> Er kommt dann natürlich auf die Wantedliste ;o)
EVGA_Gamble_add_lost_money_to_the_jackpot_percent   = 45; //Soviel Prozent vom verlorenen Geld kommt in den Jackpot
EVGA_Gamble_send_jackpot_win_to_chat                = 1;  //0=nicht senden, 1=senden
EVGA_Gamble_player_is_blocked_after_gambling        = 5; //seconds
EVGA_Gamble_reroll_if_won_factor_bandit             = 4;  //0...10 (0=never; 10=everytime)
EVGA_Gamble_reroll_if_won_factor_dice               = 1;  //0...10 (0=never; 10=everytime)
                                                      
////////////////////////////////////////////////////////////////////////////////////////////////
//ACHTUNG DIE FOLGENDEN ARRAYS DÜRFEN ZWAR VERLÄNGERT WERDEN UM WEITERE CASINOS EINZUFÜHREN,
//MÜSSEN ABER AUF JEDEN FALL ALLE GLEICH LANG SEIN!!!!!!!!!!!!!!!!!!!!!
////////////////////////////////////////////////////////////////////////////////////////////////

//Slotmaschine
EVGA_Gamble_bandit_win_factor_two_of_a_kind     = [2,  5,    201];   //zwei Gleich bei der Slotmachine
EVGA_Gamble_bandit_win_factor_three_of_a_kind   = [5, 10,   2002];  //zwei Gleich bei der Slotmachine

//Dice
EVGA_Gamble_dice_win_factor_two_of_a_kind       = [5,  10,    203];   //Pasch beim Würfeln
EVGA_Gamble_dice_win_factor_sum_seven           = [2, 5,   2004];  //Summe 7 beim Würfeln

EVGA_Gamble_casino_is_illegal                   = [0,   1,      1];     //0=nicht illegal, 1=illegal
////////////////////////////////////////////////////////////////////////////////////////////////


//Text
EVGA_Gamble_title_text                                      = "Casino";
EVGA_Gamble_won_text                                        = "Du hast gewonnen";
EVGA_Gamble_lost_text                                       = "Du hast verloren";
EVGA_Gamble_you_cant_gamble_more_then                       = "Du kannst nicht mehr bieten wie";
EVGA_Gamble_please_enter_a_value_above_zero                 = "Bitte eine Zahl größer wie 0 eingeben";
EVGA_Gamble_this_isnt_an_actual_number_format               = "Das ist keine gültige Zahl";
EVGA_Gamble_not_that_much_money                             = "Du hast nicht genug Geld";
EVGA_Gamble_blocked_please_wait                             = "Bitte warten";
EVGA_Gamble_you_have_been_watched_gambling_illegal          = "DU WURDEST BEOBACHTET! FAHNDUNG LÄUFT!";
EVGA_Gamble_send_watched_illegal_gambling_to_chat_message   = "betreibt illegale Glücksspiele!"; //vor dem Text steht immer der Name des Spielers
EVGA_Gamble_send_jackpot_won_to_chat_message                = "hat den Casino Jackpot gewonnen!"; //vor dem Text steht immer der Name des Spielers
EVGA_Gamble_jackpot_won_text                                = "Du hast den Jackpot gewonnen!";
EVGA_Gamble_jackpot_rules_text                              = "(Gewinn bei Slotmaschine 3x<img size='1.0' image='core\EVGA\icons\gambling\cat_001.paa'/>)"; //vor dem Text steht immer der Name des Spielers
EVGA_Gamble_too_far_away_from_npc                           = "Du bist zuweit vom Casino entfernt... wie sollten wir dir so das Geld geben?";



//////////////////////////////////
//Variables please don´t change
//////////////////////////////////
EVGA_Gamble_roll_time_to_wait = 0;     //the time the gamble rolls
EVGA_Gamble_roll_timer_is_running = 0; //to prevent multiple timer threads
EVGA_Gamble_last_type = "Dice";
EVGA_Gamble_casino_idx = 0; //parameter kommt vom aufrufenden NPC //0...n damit wählt man im Gewinnarray die Position aus
EVGA_Gamble_player_is_blocked = 0; //0=not blocked, 1=blocked
EVGA_Gamble_unblock_time = 0;
EVGA_Gamble_get_data_thread_is_running = 0;
EVGA_Gamble_jackpot = [-1, -1]; //[legal, illegal]
EVGA_Gamble_npc_name = ""; //der Name des Casino NPC
