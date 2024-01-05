import { Calendar } from '@fullcalendar/core';
import interactionPlugin from '@fullcalendar/interaction';
import dayGridPlugin from '@fullcalendar/daygrid';
import timeGridPlugin from '@fullcalendar/timegrid';

document.addEventListener('turbolinks:load', function() {
  var calendarEl = document.getElementById('calendar');

  var calendar = new Calendar(calendarEl, {
    plugins: [dayGridPlugin, timeGridPlugin, interactionPlugin],
    locale: 'ja',
    timeZone: 'Asia/Tokyo',
    //ボタンの位置、種類とかの設定
    headerToolbar: {
      start: 'prev,next,today',
      center: 'title',
      end: 'dayGridMonth,timeGridWeek,timeGridDay'
    },
    buttonText: {
      today: '今日'
    },
    allDayText: '終日',
    //表示させる場所、本記事ではeventsのindexにあたるルーティング
    events:'/index.json',

    // クリック時の処理
    eventClick: function(info) {
    //クリックしたら詳細ページへ
      var eventUrl = '/events/' + info.event.id;
      window.location.href = eventUrl;
    },
    //色の表示について
    eventColor: function(arg) {
      var eventColor = arg.event.color;
      return eventColor;
    },
  });
    //カレンダー表示
  calendar.render();
});