 // tabbed content
 $(".tab_content").hide();
 $(".tab_content:first").show();

 /* if in tab mode */
 $("ul.nav-tabs li").click(function() {

     $(".tab_content").hide();
     var activeTab = $(this).attr("rel");
     $("#" + activeTab).fadeIn();

     $("ul.nav-tabs li").removeClass("active");
     $(this).addClass("active");

     $(".tab_drawer_heading").removeClass("d_active");
     $(".tab_drawer_heading[rel^='" + activeTab + "']").addClass("d_active");

 });

 /* if in drawer mode */
 $(".tab_drawer_heading").click(function() {

     $(".tab_content").hide();
     var d_activeTab = $(this).attr("rel");
     $("#" + d_activeTab).fadeIn();

     $(".tab_drawer_heading").removeClass("d_active");
     $(this).addClass("d_active");

     $("ul.nav-tabs li").removeClass("active");
     $("ul.nav-tabs li[rel^='" + d_activeTab + "']").addClass("active");
 });