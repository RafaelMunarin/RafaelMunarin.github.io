function toggleNav() {
    var sidenav = document.getElementById("mySidenav");
    if (sidenav.classList.contains("collapsed")) {
        sidenav.classList.remove("collapsed");
        sidenav.classList.add("expanded");
        document.getElementById("main").style.marginLeft = "250px";
    } else {
        sidenav.classList.remove("expanded");
        sidenav.classList.add("collapsed");
        document.getElementById("main").style.marginLeft = "60px";
    }
}
