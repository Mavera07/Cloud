/**
 * Created by sahin on 5/12/17.
 */


$(function() {

});

function navigateToParent(focusPath){
    var temp = focusPath.match(/(.+)\/.+?/);
    if(temp !=null){
        window.location.href = "/index?path="+temp[1];
    }else{
        alert("Is this root?");
    }
}

function addNewNode(focuspath) {
    $.ajax({
        url: '/ajax?',
        contentType: 'application/json',
        data: {'addnode':'','path':focuspath},
        dataType: 'json',
        complete: function () {
            window.location.reload(true);
        },
    });
}

function deleteTheNode(focuspath) {

    var temp = focuspath.match(/(.+)\/.+?/);
    if(temp !=null){
        $.ajax({
            url: '/ajax?',
            contentType: 'application/json',
            data: {'deletenode':'','path':focuspath},
            dataType: 'json',
            complete: function () {
                window.location.href = "/index?path="+temp[1];
            },
        });
    }else{
        alert("Is this root?");
    }
}

function editTheNode(focuspath) {
    var editedFocusName = $("#editedfocusname").val();

    $.ajax({
        url: '/ajax?',
        contentType: 'application/json',
        data: {'editnode':'','path':focuspath,'name':editedFocusName},
        dataType: 'json',
        complete: function () {
            window.location.href = "/index?path="+focuspath;
        },
    });
}
