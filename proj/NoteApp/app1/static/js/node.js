/**
 * Created by sahin on 5/13/17.
 */

$(function() {

});

function saveNotes(focuspath){

    var notes = $(".ql-editor").get(0).innerHTML;

    $.ajax({
        url: '/ajax?',
        contentType: 'application/json',
        data: {'savehtml':notes,'path':focuspath},
        dataType: 'json',
        complete: function () {
            $("#savenotesmodal").modal('show');
        },
      });
}

function navigateToNetwork(focuspath){
    window.location.href = "/index?path="+focuspath;
}
