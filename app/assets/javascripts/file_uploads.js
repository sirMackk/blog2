//remove this from application.js

var id = 0, url = 1, thumb = 2;
$(document).ready(function() {
    //get image list of urls and ids
    var getImages = function() {
        $.ajax({
        url: $("#file_upload").attr("action"),
        type: "get",
        success: function(data) {
            var html = "";
            $.each(data, function(index, value) {
                //clean up this string thing
                // and add non markdown html input
                // and turn into seperate js file
                // and view helper
                html += "<tr>\
                <td>\
                    <a href=\"" + value[url] + "\">\
                    <img src=\"" + value[thumb] + "\">\
                </td>\
                <td>\
                <span>[<%= root_path %>" + value[thumb] + 
                    "](<%= root_path %>" + value[url] + 
                    ")</span>\
                </td>\
                <td>\
                <button class=\"deleteImg\" value=" + value[id] + ">X</button>\
                </td>\
                </tr>"

            });
            $("#uploaded_images table tbody").append(html);
        }
        });
    };


    //click the x button, send DELETE, fadeout and remove tr
    $(document.body).on("click", "button.deleteImg", function(event) {
        event.preventDefault();
        var imgId = $(this).attr("value");
        var row = $(this).parents()[1];
        var self = this;
        $.ajax({
            url: $("#file_upload").attr("action") + "/" + imgId,
            type: "DELETE",
            complete: function(data) {
                $(row).fadeOut("fast", function() {
                    $(self).parents()[1].remove();
                });
            }
        });
    });
    
    //upload new images, call above to refresh list
    $("#file_upload").submit(function(event) {

        var formData = new FormData($(this)[0]);
        $.ajax({
            url: $(this).attr("action"),
            type: $(this).attr("method"),
            enctype: "multipart/form-data",
            data: formData,
            processData: false,
            contentType: false,
            success: function(data) {
                $("#uploaded_images table tbody tr").remove();
                getImages();
            }
        });
        return false;
    });

    getImages();

});