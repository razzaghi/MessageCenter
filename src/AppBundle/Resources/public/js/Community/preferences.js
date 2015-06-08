/* freepost
 * http://freepo.st
 *
 * Copyright � 2014-2015 zPlus
 * 
 * This file is part of freepost.
 * freepost is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 * 
 * freepost is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
 * GNU General Public License for more details.
 * 
 * You should have received a copy of the GNU General Public License
 * along with freepost. If not, see <http://www.gnu.org/licenses/>.
 */

(function() {

    var communityImage;         // The picture in the side bar
    var pictureFile;            // <input type=file> to select community picture 
    var pictureFileLoading;     // Loading GIF to display while uploading community picture
    var pictureForm;            // <form> containing pictureFile
    var displayName;            // <input type=text> with the community name
    var iframenull;             // The hidden iform to redirect form ajax requests
    
    /* This is used to receive a response from iframenull when a user changes
     * community picture, so that I know when it finished uploading.
     */
    window.addEventListener(
        "message",
        function(event) {
            // Do we trust the sender of this message?  (might be
            // different from what we originally opened, for example).
            //if (event.origin !== "http://example.org")
            //    return;
            
            // event.source
            // event.data
            
            switch (event.data.action.toUpperCase())
            {
                // Community picture uploaded
                case "UPDATECOMMUNITYPICTURE":
                    pictureFileLoading.hide();
                    pictureForm.show();
                    
                    // Reload menu picture on side bar
                    if (event.data.status.toUpperCase() == "DONE")
                        communityImage.attr("src", communityImage.attr("src") + "?" + Math.random());
                    
                    break;
                default:
                    break;
            }
        },
        false
    );
        
    $(document).ready(function() {
        
        communityImage      = $(".communityMenu > .picture > .image");
        iframenull          = $("#iframenull");
        pictureFile         = $("#pictureFile");
        pictureFileLoading  = $("#pictureFileLoading");
        pictureForm         = $("#pictureForm");
        displayName         = $("#displayName");

        pictureForm.on("submit", function() {
            pictureForm.hide();
            pictureFileLoading.show();
        });
        
        pictureFile.on("change", function() {
            pictureForm.submit();
        });
        
        displayName.on("change", function() {
            
            // URL used to POST the new name
            var url = Routing.generate(
                "freepost_community_update_name",  // route
                {                               // route params
                    communityHashId: $("input[name=communityHashId]").val()
                },
                true                            // absolute URL
            );
            
            $.ajax({
                type:   "post",
                url:    url,
                data:   {
                    displayName: displayName.val()
                },
                dataType:	"json"
            })
            .done(function(response) {
                console.log(response);
            })
            .fail(function(response) {
                console.log(response);
            });
        });
        
    });
    
})();