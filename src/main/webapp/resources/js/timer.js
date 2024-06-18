class Timer {
    interval;

    getToken(check_number, check_number_post, check_complete, check_timer) {
        const tk = String(Math.floor(Math.random()*1000000)).padStart(6,"0");
        check_number.text(tk);
        check_number_post.attr("disabled", true);
        check_complete.attr("disabled", false);
        this.getTimerInterval(check_number, check_number_post, check_complete, check_timer);
    }

    getTimerIntervalConfirm(check_complete, sign) {
        clearInterval(this.interval);
        check_complete.attr("disabled", true);
        check_complete.text("인증완료");
        alert("인증이 완료되었습니다.");
        sign.attr("disabled", false);
    }

    getTimerInterval(check_number, check_number_post, check_complete, timer) {
        let min = 3;
        let sec = 0;
        this.interval = setInterval(function() {
            if(sec == 0) {
                min--;
                sec = 59;
            }
            else{
                sec--;
            }
            $("#check_timer").text(min+":"+sec);
            if(sec ==0 && min == 0) {
                clearInterval(this.interval);
            }
        }, 1000);
    }
}