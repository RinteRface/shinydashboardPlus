$(function() {
  // box vertical overflow
  $(".content-wrapper").css("overflow-y", "auto");

  // slide to top button
  var $slideToTop = $("<div />");

  $slideToTop.html('<i class="fa fa-chevron-up"></i>');

  $slideToTop.css({
    position: "fixed",
    bottom: "20px",
    right: "25px",
    width: "40px",
    height: "40px",
    color: "#eee",
    "font-size": "",
    "line-height": "40px",
    "text-align": "center",
    "background-color": "#222d32",
    cursor: "pointer",
    "border-radius": "5px",
    "z-index": "99999",
    opacity: ".7",
    display: "none"
  });

  $slideToTop.on("mouseenter", function() {
    $(this).css("opacity", "1");
  });

  $slideToTop.on("mouseout", function() {
    $(this).css("opacity", ".7");
  });

  $(".wrapper").append($slideToTop);

  $(window).scroll(function() {
    if ($(window).scrollTop() >= 150) {
      if (!$($slideToTop).is(":visible")) {
        $($slideToTop).fadeIn(500);
      }
    } else {
      $($slideToTop).fadeOut(500);
    }
  });

  $($slideToTop).click(function() {
    $("html, body").animate(
      {
        scrollTop: 0
      },
      500
    );
  });

  // code to make sure that a carousel item is displayed
  // when it is generated via a shiny Output function
  // Thanks Dean Attali for the report
  $(".carousel").on("slide.bs.carousel", function() {
    $(this).trigger("shown");
  });

  // overwrite box animation speed. Putting 500 ms add unnecessary delay for Shiny.
  $.AdminLTE.boxWidget.animationSpeed = 10; 
  hasGlobalConfig = $(document).find("script[data-for='adminLTEConfig']");
  if (hasGlobalConfig.length > 0) {
    globalConfig = JSON.parse(hasGlobalConfig.html());
    if (globalConfig.boxWidget.animationSpeed !== undefined) {
      $.AdminLTE.boxWidget.animationSpeed = globalConfig.boxWidget.animationSpeed;
    }
  }

  /**
   * List of all the available skins
   *
   * @type Array
   */
  var mySkins = [
    "skin-blue",
    "skin-black",
    "skin-red",
    "skin-yellow",
    "skin-purple",
    "skin-green",
    "skin-blue-light",
    "skin-black-light",
    "skin-red-light",
    "skin-yellow-light",
    "skin-purple-light",
    "skin-green-light"
  ];

  /**
   * Store a new settings in the browser
   *
   * @param String name Name of the setting
   * @param String val Value of the setting
   * @returns void
   */
  function store(name, val) {
    if (typeof Storage !== "undefined") {
      localStorage.setItem(name, val);
    } else {
      window.alert(
        "Please use a modern browser to properly view this template!"
      );
    }
  }

  /**
   * Replaces the old skin with the new skin
   * @param String cls the new skin class
   * @returns Boolean false to prevent link's default action
   */
  changeSkin = function(cls) {
    $.each(mySkins, function(i) {
      $("body").removeClass(mySkins[i]);
    });

    $("body").addClass(cls);
    store("skin", cls);
    return false;
  };
});

