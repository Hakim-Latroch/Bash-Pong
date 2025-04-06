

frame_sleep=0.01
height=35
width=100
ball_x=width
ball_y=15
loading_time=1
score_p1=0
score_p2=0


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
 printf "\033[${ball_x}G" 

 echo '[ ]';


}


update_ball() {
    sleep 0.1
    ball_x=$((ball_x-1))
    if [ $ball_x -gt 150 ]; then
        score_p1=$((score_p1+1))
        ball_x=100
    fi

    if [ $ball_x -lt 51 ]; then
        score_p2=$((score_p2+1))
        ball_x=100
    fi
    
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
 
 ball
 update_ball
echo -ne ' '

 2dplane
 
 

sleep $frame_sleep





done




}







Splash

sleep $loading_time

game




