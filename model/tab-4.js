function editComida(id)
{
    document.getElementById("tab-4-noId").className = "tab-4-content-hidden";
    document.getElementById("tab-4-content").className = "tab-4-content";
    changeTab(4);
}

function closeEdit()
{
    document.getElementById("tab-4-noId").className = "tab-4-content";
    document.getElementById("tab-4-content").className = "tab-4-content-hidden";
}