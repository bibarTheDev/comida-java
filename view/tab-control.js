
function changeTab(tabNum)
{
    let numTabs = document.getElementById('tab-control').children.length;

    for(let i = 1; i <= numTabs; i++){
        let tabElem = document.getElementById('tab-'  +  i);
        let tabButton = document.getElementById('tab-button-'  +  i);
        if(i == tabNum){
            tabElem.className = "tab-visible";
            tabButton.className = "tab-button-selected";
        }
        else{
            tabElem.className = "tab-hidden";
            tabButton.className = "tab-button";
        }            
    }
}