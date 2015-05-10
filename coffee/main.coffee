root = PhotoApp.request "get:layout:root"
main = PhotoApp.request "get:layout:app"

root.bodyRegion.show main
