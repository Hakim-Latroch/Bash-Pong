

frame_sleep=0.01
height=35
width=100
ball_x=$width
ball_y=20
ball_speed=0.04
ball_direction_x=1
ball_direction_y=1
loading_time=1
score_p1=0
score_p2=0
player1_speed=1
player2_speed=1
player1_y=18
player2_y=18
player1_x=60
player2_x=143
paddle_height=$height/4

player1_bottom=$(($player1_y + $paddle_height))
player2_bottom=$(($player2_y + $paddle_height))


Splash() {
progress=""
echo "Welcome to Pong";
echo "";

for i in $(seq 1 100);
do 

echo -ne "\033[A\r[$i]"
echo -ne "\033[B"
progress="$progress="
echo -ne "$progress"; 

sleep 0.01

done
sleep 0.2

clear 

}
ball() {
 
 printf "\033[${ball_y};${ball_x}H"

 echo -ne '[-]';

}



player1() {

 printf "\033[18;60H"
 for ((y=0; y<$height/4; y++)); do
    printf "\033[$((player1_y + y));60H"
    echo -ne "|| "
 
 done
 
}



player2() {


 for ((y=0; y<$paddle_height; y++)); do
    printf "\033[$((player2_y + y));143H"
    echo -ne "|| "
 
 done
 
}



update_ball() {

    sleep $ball_speed

    ball_x=$((ball_x+ball_direction_x))
    ball_y=$((ball_y+ball_direction_y))


##wall bounce
    if [ $ball_y -gt 38 ]; then
        ball_direction_y=$(( ball_direction_y * -1))

    fi

    if [ $ball_y -lt 5 ]; then
        ball_direction_y=$(( ball_direction_y * -1))
      
    fi

    ##paddle bounce

    if [[ $ball_x -eq $player1_x && $ball_y -le $player1_bottom && $ball_y -ge $player1_y ]]; then
        ball_direction_x=$(( ball_direction_x * -1))
        ball_direction_y=$(( ball_direction_y * -1))
    fi
##P2
    if [[ $ball_x -eq $player2_x  && $ball_y -le $player2_bottom && $ball_y -ge $player2_y ]]; then
        ball_direction_x=$(( ball_direction_x * -1))
        ball_direction_y=$(( ball_direction_y * -1))
    fi

    

##scoring 

    if [ $ball_x -gt 150 ]; then
        score_p1=$((score_p1+1))
        ball_x=100
        ball_y=20
        ball_direction_x=$(( ball_direction_x * -1))
    fi

    if [ $ball_x -lt 51 ]; then
        score_p2=$((score_p2+1))
        ball_x=100
        ball_y=20
        ball_direction_x=$(( ball_direction_x * -1))
    fi
 

    echo -n " "
    
}

2dplane() {
     for ((x=0; x<$width/2; x++)); do
    echo -n " "
    done
     for ((x=0; x<$width; x++)); do
    echo -n "_"
    done
    
    echo ''
 

    for ((y=0; y<$height; y++)); do
       for ((x=0; x<$width/2; x++)); do
    echo -n " "
    done
    echo -n "|"
    for ((x=0; x<$width; x++)); do
    echo -n " "
    done
    echo "|"
    done
        for ((x=0; x<$width/2; x++)); do
    echo -n " "
    done
     for ((x=0; x<$width; x++)); do
    echo -n "_"
    done
    
    echo ''


    
}









game() {
 
 while true;
 do

 printf "\033[0;0H"
 
 echo -e "\e[?25l"
 

 for ((x=0; x<$width-8; x++)); do
    echo -n " "
 done
 echo " Score: $score_p1 || $score_p2"
  2dplane
    printf "\033[0;0H"
    echo " "
    player1

     printf "\033[0;0H"
    echo " "
    player2
  printf "\033[0;0H"
   echo " "
    ball
  
    update_ball

   



 


sleep $frame_sleep





done




}







Splash

sleep $loading_time

game




