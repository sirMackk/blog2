var id = 0, url = 1, thumb = 2;
//$(document).ready(function() {
setTimeout(function() {
    //get image list of urls and ids
    var getImages = function() {
        var rootPath = $("#file_upload").attr("value");
        $.ajax({
        url: $("#file_upload").attr("action"),
        type: "get",
        success: function(data) {
            console.log("loaded images");
            console.log(typeof(data));
            var html = "";
            $.each(data, function(index, value) {
                //TODO: clean up this string thing
                html += "<tr>\
                <td>\
                    <a href=\"" + value[url] + "\">\
                    <img src=\"" + value[thumb] + "\"></a>\
                </td>\
                <td>Html:\
                <div>&lt;a class=\"image\" href=\"" + rootPath + value[url] +
                "\"&gt;&lt;img src=\"" + rootPath + value[thumb] +
                "\"&gt;&lt;/a&gt</div>Markdown:\
                <div>[" + rootPath + value[thumb] + 
                    "](" + rootPath + value[url] + 
                    ")</div>\
                Absolute url:\
                <div>" + rootPath + value[url] +
                "</td>\
                <td>\
                <button class=\"deleteImg\" value=" + value[id] + 
                    ">X</button>\
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

}, 1500);
