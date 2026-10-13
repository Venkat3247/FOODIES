/* =========================================================
   FOODIES - LOADER CONTROL
   Step 3
   ========================================================= */

(function () {

    "use strict";

    function hideFoodiesLoader() {

        const loader = document.getElementById("foodies-loader");

        if (!loader) {
            return;
        }

        loader.style.opacity = "0";
        loader.style.visibility = "hidden";
        loader.style.pointerEvents = "none";

        setTimeout(function () {

            loader.style.display = "none";

        }, 400);
    }


    function showFoodiesLoader() {

        const loader = document.getElementById("foodies-loader");

        if (!loader) {
            return;
        }

        loader.style.display = "flex";
        loader.style.opacity = "1";
        loader.style.visibility = "visible";
        loader.style.pointerEvents = "auto";
    }


    window.foodiesLoader = {

        show: showFoodiesLoader,

        hide: hideFoodiesLoader

    };


    window.addEventListener("load", function () {

        hideFoodiesLoader();

    });

})();