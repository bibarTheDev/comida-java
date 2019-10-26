
function changeTab(tabNum)
{
    let numTabs = document.getElementById('tab-control').children.length + 1;

    for(let i = 1; i < numTabs; i++){
        let tabElem = document.getElementById('tab-'  +  i);
        if(i == tabNum){
            tabElem.className = "tab-visible";
        }
        else{
            tabElem.className = "tab-hidden";
        }            
    }
}