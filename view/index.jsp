<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>Document</title>

    <link rel="stylesheet" href="style.css">

    <script src="tab-control.js"></script>
    <script src="../model/tab-1.js"></script>
    <script src="../model/main.js"></script>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
</head>
<body>
    <div id="mae">
        <!--tab control-->
        <div id="tab-control">
            <div class="tab-button-selected" id="tab-button-1" onclick="changeTab(1)">Tab 1</div>
            <div class="tab-button" id="tab-button-2" onclick="changeTab(2)">Tab 2</div>
            <div class="tab-button" id="tab-button-3" onclick="changeTab(3)">Tab 3</div>
        </div>

        <!--tabs-->
        <div id="tabs">
            <div id="tab-1" class="tab-visible">
                yo soy tab 1
            </div>
            <div id="tab-2" class="tab-hidden">
                yo soy tab 2
            </div>
            <div id="tab-3" class="tab-hidden">
                yo soy tab 3
            </div>
        </div>
    </div>
</body>
</html>