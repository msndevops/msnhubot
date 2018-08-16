// Description:
//   Skeletor is experiencing the profound emptiness and isolation
//   of human existence. Follow his journey to positive mental health
//   through daily affirmations
//
// Dependencies:
//   None
//
// Configuration:
//   none
//
// Commands:
//   hubot affirm me - displays a random image from skeletorislove.tumblr.com
//
// Author:
//   steveax

var affirmations = [
  'http://24.media.tumblr.com/3fc3cf25347301a1fb46a1a50e8a0db7/tumblr_mvsm5swKoA1s46h7vo1_500.jpg',
  'http://24.media.tumblr.com/4d67e4aa32edfc1102bf36ae11d8ea0a/tumblr_n0s90yqlpV1s46h7vo1_500.jpg',
  'http://24.media.tumblr.com/507827189ac2704102ee0d78ae9055a0/tumblr_mwxgkvg2tX1s46h7vo1_500.jpg',
  'http://24.media.tumblr.com/8da08476cab956fcce80c6b698164301/tumblr_mt7wk8NFrz1s46h7vo1_500.jpg',
  'http://24.media.tumblr.com/cbac0166e3cd27f96db9f86d7b9cf5af/tumblr_msuzpt07g31s46h7vo1_500.jpg',
  'http://25.media.tumblr.com/116f74d8810d7e8805464402cfe5964b/tumblr_n2jw14cMsO1s46h7vo1_500.jpg',
  'http://25.media.tumblr.com/138eca34cd57253753e08bb9daf808be/tumblr_moo30d5vQ21s46h7vo1_500.jpg',
  'http://25.media.tumblr.com/13ac9d25afddd4212b6c043ef440d544/tumblr_mrzhii5ROD1s46h7vo1_500.jpg',
  'http://25.media.tumblr.com/14a2480ddbbe782e510b127c59d32b72/tumblr_mojetbmvPm1s46h7vo1_500.jpg',
  'http://31.media.tumblr.com/e9afdfcccb469db8ae23f4c89e7bd4e8/tumblr_mvyb1i01na1s46h7vo1_500.jpg',
  'http://33.media.tumblr.com/35d86ee3896eb0b868169be2830d5878/tumblr_n7mkqrbD8b1s46h7vo1_500.jpg',
  'http://40.media.tumblr.com/0bd716f3eb0cbe82d5b87a4780f5c90a/tumblr_mqwnjxhwRR1s46h7vo1_500.jpg',
  'http://i.imgur.com/aFR5k02.jpg',
  'https://howtobealibrarian.files.wordpress.com/2014/09/tumblr_n4ujobzyzi1s46h7vo1_500.jpg',
  'http://www.realclear.com/assets/photos/239279_5_.jpg',
  'http://i.imgur.com/U9bqWHQ.jpg',
  'http://i.kinja-img.com/gawker-media/image/upload/s--8A8vNchv--/c_fit,fl_progressive,q_80,w_636/sdugzhql0glefdfmgjhb.jpg',
  'http://25.media.tumblr.com/7d432b2762bab5860bcb7d312be3f513/tumblr_myzgfak1jc1qbge4co1_1280.jpg',
  'https://kchapmangibbons.files.wordpress.com/2014/03/1237019_223339761154790_1548232140_n.jpg',
  'https://robotxrobot.files.wordpress.com/2014/04/tumblr_n3o19khz2y1s46h7vo1_500.jpg',
  'http://i.imgur.com/NDb4joB.jpg',
  'https://s-media-cache-ak0.pinimg.com/736x/bc/d0/65/bcd06510065e6080c6feb92bb89f8590.jpg',
  'http://41.media.tumblr.com/252f8e13eb0cde2465e46076fd988670/tumblr_n84xkeaD4K1s46h7vo1_500.jpg',
  'http://i.kinja-img.com/gawker-media/image/upload/s--ZAiSeIcj--/c_fit,fl_progressive,q_80,w_636/cfxe4zbs6rd5lirgqrsd.jpg',
  'http://41.media.tumblr.com/4d67e4aa32edfc1102bf36ae11d8ea0a/tumblr_n0s90yqlpV1s46h7vo1_500.jpg',
  'http://i.imgur.com/v4wCiSA.jpg',
  'https://s-media-cache-ak0.pinimg.com/736x/28/91/a3/2891a32fc63001c5427cc71d76a9ea5e.jpg',
  'http://31.media.tumblr.com/9b56c99acde9f561cc50fc9ecd8508a8/tumblr_n17mf6Nlnt1qbge4co1_1280.jpg'
];

function shuffle(array) {
  var currentIndex = array.length,
    temporaryValue,
    randomIndex;

  while(0 !== currentIndex) {

    randomIndex = Math.floor(Math.random() * currentIndex);
    currentIndex -= 1;

    temporaryValue = array[currentIndex];
    array[currentIndex] = array[randomIndex];
    array[randomIndex] = temporaryValue;
  }

  return array;
}

function get_random_affirmation() {
  shuffle(affirmations);
  return affirmations[0];
}

module.exports = function(robot) {
  robot.hear(/affirm me/i, function(msg) {
    var affirmation = get_random_affirmation();
    msg.send(affirmation);
  });
};

