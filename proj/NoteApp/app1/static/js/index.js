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
        window.location.href = "/index?path="+focusPath;
    }
}
