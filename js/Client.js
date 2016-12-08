.import "System.js" as System

function post(message, author) {
    console.log(message)
    var request = new XMLHttpRequest()
    request.open("POST", System.server + "/send.php")
    request.setRequestHeader("Content-Type", "application/x-www-form-urlencoded")
    var param = "author=" + author+"&message=" + message
    request.onreadystatechange = function () {
        if (request.readyState === XMLHttpRequest.DONE) {
            if (request.status === 200) {
                if(request.responseText == "1")
                    console.log("sending")
                else if(request.responseText == "-1")
                   loginError("error")
                else
                    console.log(request.responseText)
            }
        }
    }

    request.send(param)
}


function get(lastId) {
    var request = new XMLHttpRequest()
    if(lastId == 0)
        return;
    request.open("POST", System.server + "/get.php")
    request.setRequestHeader("Content-Type", "application/x-www-form-urlencoded")
    var response
    var param = "lastid="+lastId
    request.onreadystatechange = function () {
        if (request.readyState === XMLHttpRequest.DONE) {
            if (request.status === 200) {
                if(request.responseText != "-1") {
                    response = request.responseText
                    var t = JSON.parse(response)
                        if(t)
                            if(parseInt(t[0].id) > parseInt(chat.msgLastId) && parseInt(t[t.length-1].id) > parseInt(chat.msgLastId)) {
                            for(var i = 0; i < t.length; i++) {
                                if(parseInt(t[i].id) > chat.msgLastId)
                                chat.mod.append({"id":t[i].id, "text1": t[i].message, "author" : t[i].author, "time":t[i].date})
                            }
                            chat.setMsgLastId(parseInt(t[t.length-1].id))
                            list.currentIndex = mod.count - 1
                            loadMsg.visible = false
                        }
                } else {console.log("empty")}
            }
        }
    }
    request.send(param)
}

function update(firstId) {
    var request = new XMLHttpRequest()
    request.open("POST", System.server + "/update.php")
    request.setRequestHeader("Content-Type", "application/x-www-form-urlencoded")
    var response
    var param = "firstid="+firstId
    request.onreadystatechange = function () {
        if (request.readyState === XMLHttpRequest.DONE) {
            if (request.status === 200) {
                if(request.responseText != "-1") {
                    response = request.responseText
                    var t = JSON.parse(response)
                        if(t) {
                            if(parseInt(t[t.length-1].id) < parseInt(chat.mod.get(0).id)) {
                                for(var i = t.length-1; i > 0; i--) {
                                    if(parseInt(t[i].id) < parseInt(chat.mod.get(0).id))
                                        chat.mod.insert(0,{"id":t[i].id, "text1": t[i].message, "author" : t[i].author, "time":t[i].date})
                                }
                            }
                        }
                } else {console.log("empty")}
            }
        loadMsg.visible = false
        }
    }
    request.send(param)

}
