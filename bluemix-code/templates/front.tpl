<head>
    <meta charset="utf-8">
    <title>Natural Language Scheduler</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" integrity="sha384-BVYiiSIFeK1dGmJRAkycuHAHRg32OmUcww7on3RYdg4Va+PmSTsz/K68vbdEjh4u" crossorigin="anonymous">
</head>

<body>
<div class="btn-group">
  <h1> Please Select Who You Are </h1>
  <button type="button" class="btn btn-default dropdown-toggle" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
    Select <span class="caret"></span>
  </button>
  <ul class="dropdown-menu">
    <li><a href="index">Student</a></li>
    <li><a href="#">Professor</a></li>
    <li><a href="#">Admin</a></li>
  </ul>
</div>
  <form method="post">
    Query: <input name="query" type="text" />
    <input type="submit" />
  </form>


  <!-- Bootstrap Core JavaScript -->
  <script src="https://code.jquery.com/jquery-3.2.1.min.js" integrity="sha256-hwg4gsxgFZhOsEEamdOYGBf13FyQuiTwlAQgxVSNgt4="
          crossorigin="anonymous"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>

</body>