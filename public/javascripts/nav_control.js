/* DO NOT MODIFY. This file was compiled Sat, 18 Feb 2012 03:47:56 GMT from
 * /Users/jessesmith/Documents/BetterSense/www/BetterSenseDemoDev/BetterSenseDemo/app/coffeescripts/nav_control.coffee
 */

(function() {
  var root;

  root = typeof exports !== "undefined" && exports !== null ? exports : this;

  $(function() {
    var path, slash;
    path = document.location.pathname.substr(1);
    slash = path.indexOf("/");
    if (slash !== -1) path = path.substr(0, slash);
    if (!(path != null) || path === "") path = "home";
    return $('#nav_' + path).addClass("current");
  });

}).call(this);
