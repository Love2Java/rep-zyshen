
function initToolbar() {
    showButton("btnSh", false);
    showButton("btnQh", false);
    showButton("btnSp", false);
    showButton("btnQp", false);
    showButton("btnFinish", false);
    showButton("btnSave", false);
    showButton("btnCancel", false);
    showButton("divForm", false);
}
function cancelClick() {
    showButton("btnSave", false);
    showButton("btnCancel", false);
    showButton("divForm", false);
    showButton("btnAdd", true);
    showButton("btnEdit", true);
    showButton("btnDelete", true);
    showButton("btnReload", true);
    showButton("btnFirst", true);
    showButton("btnPrevious", true);
    showButton("btnNext", true);
    showButton("btnLast", true);
}
function addClick() {
    showButton("btnSh", false);
    showButton("btnQh", false);
    showButton("btnSp", false);
    showButton("btnQp", false);
    showButton("btnFinish", false);
    showButton("btnSave", true);
    showButton("btnCancel", true);
    showButton("divForm", true);
    showButton("btnAdd", false);
    showButton("btnEdit", false);
    showButton("btnDelete", false);
    showButton("btnReload", false);
    showButton("btnFirst", false);
    showButton("btnPrevious", false);
    showButton("btnNext", false);
    showButton("btnLast", false);
}
function editClick() {
    showButton("btnSh", false);
    showButton("btnQh", false);
    showButton("btnSp", false);
    showButton("btnQp", false);
    showButton("btnFinish", false);

    showButton("btnSave", true);
    showButton("btnCancel", true);
    showButton("divForm", true);
    showButton("btnAdd", false);
    showButton("btnEdit", false);
    showButton("btnDelete", false);
    showButton("btnReload", false);
    showButton("btnFirst", false);
    showButton("btnPrevious", false);
    showButton("btnNext", false);
    showButton("btnLast", false);
}
function saveClick() {
    showButton("btnSave", false);
    showButton("btnCancel", false);
    showButton("divForm", false);
    showButton("btnAdd", true);
    showButton("btnEdit", true);
    showButton("btnDelete", true);
    showButton("btnReload", true);
    showButton("btnFirst", true);
    showButton("btnPrevious", true);
    showButton("btnNext", true);
    showButton("btnLast", true);
}