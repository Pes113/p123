class ReplyService {
    
    static add(reply, callback){
        console.log("add reply....................");
        
        $.ajax({
            type : 'post',
            url : '/replies/new2',
            data : JSON.stringify(reply),
            contentType : "application/json; charset=utf-8",
            success : function(result, status, xhr){
                if(callback){
                    callback(result);
                }
            },
            error : function(xhr, status, error){
                if(error){
                    error(xhr.status + ' ' + status);
                }
            }
        });
    }

    static get(param, callback) {
        var rno = param;
		
		$.getJSON( "/replies/" + rno, function(data){
					if(callback){
						callback(data);
					}
		}).fail(function(xhr, status, error){
			if(error){
				error();
			}
		});
    }

    static modify(rno, reply, callback) {
		
        $.ajax({
            type : 'patch',
            url : '/replies/' + rno,
            data : JSON.stringify(reply),
            contentType : "application/json; charset=utf-8",
            success : function(result, status, xhr){
                if(callback){
                    callback(result);
                }
            },
            error : function(xhr, status, error){
                if(error){
                    error(xhr.status + ' ' + status);
                }
            }
        });
    }

    static remove(rno, callback) {
        $.ajax({
            type : 'delete',
            url : '/replies/' + rno,
            success : function(result, status, xhr){
                if(callback){
                    callback(result);
                }
            },
            error : function(xhr, status, error){
                if(error){
                    error(xhr.status + ' ' + status);
                }
            }
        });
    }

    static getList(param, callback) {
        var bno = param;
		
		$.getJSON( "/replies/page/" + bno, function(data){
					if(callback){
						callback(data);
					}
		}).fail(function(xhr, status, error){
			if(error){
				error();
			}
		});
    }

    static modifyReply(rno, reply, callback) {
        
        $.ajax({
            type : 'post',
            url : '/replies/' + rno,
            data : JSON.stringify(reply),
            contentType : "application/json; charset=utf-8",
            success : function(result, status, xhr){
                if(callback){
                    callback(result);
                }
            },
            error : function(xhr, status, error){
                if(error){
                    error(xhr.status + ' ' + status);
                }
            }
        });
    }

    static getListWithPaging(param, callback) {
        let bno = param.bno;
        let page = param.page;
        $.getJSON( "/replies/page/" + bno +"/" + page, function(data){
            if(callback){
                callback(data);
                        }
            }).fail(function(xhr, status, error){
                if(error){
                    error();
                }
        });
    }

    static displayTime(timeValue){
        var today = new Date(); // 현재 시간
        var gap = today.getTime() - timeValue;
        // 시간차이 연산.
        var dateObj = new Date(timeValue);
        // 덧글이 등록된 시간을 변수에 할당.
        var str = "";
        
        if(gap<(1000*60*60*24)){
            // 시간차이가 24시간 미만이 라면,
            var hh = dateObj.getHours();
            var mi = dateObj.getMinutes();
            var ss = dateObj.getSeconds();
            
            return [ (hh>9?'':'0')+hh, ':'
                    ,(mi>9?'':'0')+mi ,':'
                    ,(ss>9?'':'0')+ss].join('');

            // 배열 요소를 문자열로 변환. join
            // 시간에 포맷을 맞추기 위해서
            // 0~9 까지는 앞에 0을 추가 표시.
        }else{
            var yy = dateObj.getFullYear();
            var mm = dateObj.getMonth()+1;
            var dd = dateObj.getDate();
            
            return [yy, '/', (mm>9?'':'0')+mm, '/',
                (dd>9?'':'0')+dd].join('');
        }
    }

};
