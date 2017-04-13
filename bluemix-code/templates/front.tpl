<head>
    <meta charset="utf-8">
    <title>Natural Language Scheduler</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" integrity="sha384-BVYiiSIFeK1dGmJRAkycuHAHRg32OmUcww7on3RYdg4Va+PmSTsz/K68vbdEjh4u" crossorigin="anonymous">
    <link rel="stylesheet" type="text/css" href="style.css">
    <link href="https://fonts.googleapis.com/css?family=Roboto" rel="stylesheet">

</head>

<body>
  <div class="jumbotron">
    <div class="container">
      <h1 class="text-center"> Welcome to the Natrual Language Scheduler</h1>
      <p> Interact with your schedule in the most intuitive way possible: regular sentences. Add and remove classes, search for professors, and view any detail you want simply by requesting the information in plain English.</p>
    </div>
  </div>
  <div class="box">
    <h3> Just enter a regular question to get information on your schedule: </h3>
    <form method="post">
      <input class="custom-query-input" name="query" type="text" placeholder="Enter Request" />
      <input class="custom-query-button" type="submit" />
    </form>
    <h3>Add or remove an item from the database:</h3>
      <form action="/inserted" method="post">
        <input class="custom-query-input" type="text" name="task" placeholder="Enter Updates" />
        <input class="custom-query-button" type="submit" name="save" value="Submit">
      </form>
  </div>


  <!-- Bootstrap Core JavaScript -->
  <script src="https://code.jquery.com/jquery-3.2.1.min.js" integrity="sha256-hwg4gsxgFZhOsEEamdOYGBf13FyQuiTwlAQgxVSNgt4="
          crossorigin="anonymous"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>

</body>