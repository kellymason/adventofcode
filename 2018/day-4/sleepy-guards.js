// Sorter function
// reads input.txt
// parses timestamps to sort each line
// returns an array of objects representing each message:
  // { 
  //   month: int, 
  //   day: int, 
  //   hour: int, 
  //   minute: int, 
  //   message: str 
  // }
function format_input() {
  // Look up file reader syntax/functions in js
  const formatted_array = [];
  input.forEach(line => {
    let formatted_message = {
      // regex matching to get fields
    };
    formatted_array.push(formatted_message);
  });
  return formatted_array;
}

// Array of message objects
// where message is either:
  // sleep start (hh always equals 00)
  // sleep stop (hh always equals 00)
  // change guard
// return object { guard_id: [message, message, message] }
function sort_messages_by_guard(formatted_messages) {
  // js syntax for sorting
  // let guard_schedules = {};
  let current_guard;
  formatted_messages.forEach(event => {
    // if message contains "Guard#"
      // something like, current_guard = Regex.find(guard_id) 
    // else
      // for (i = day.length; i <= minute; i++)
      //  schedule.day.exists? day.push(message); : schedule.day = [message];
  });
}

// minutes_asleep: Array<Integer>
// return: Integer count of minutes where asleep == true
function sleep_minutes_by_guard(sleep_schedule) {
  // find syntax for count of occurrences of a given array element value
}

// guard_id: [m,m,m,m,m,m,m,]

// return: guard_id of guard with highest sleep minutes count
function find_sleepiest_guard(guards) {
  // determine which guard has the highest sleep minutes
}

// return: most frequently occurring minute value
function find_sleepiest_minute(guard_id) {
  // get counts of each minute (summed up across all days)
  // return integer of minute with highest count
}

function solve() {
  const formatted_messages = format_input();
  const messages_by_guard = sort_messages_by_guard(formatted_messages);
  const guard_sleep_minutes = sleep_minutes_by_guard(messages_by_guard);
  const sleepiest_guard = find_sleepiest_guard(guard_sleep_minutes);
  return find_sleepiest_minute(sleepiest_guard);
}
  
