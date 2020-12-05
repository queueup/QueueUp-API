# frozen_string_literal: true

class NotificationText
  def self.new_match_membership
    {
      headings: {
        de: '🎉 Neues Match!',
        en: '🎉 New match !',
        es: '🎉 Nuevo partido !',
        fr: '🎉 Nouveau match !',
        nl: '🎉 Nieuwe match!',
        ru: '🎉 Новый друг !'
      },
      contents: {
        de: 'Du hast gerade mit einem neuen Spieler gematcht. Schick ihm eine Nachricht!',
        en: 'You just matched with a new player. Send him a message!',
        es: 'Acababas de emparejar con un nuevo jugador. Envíale un mensaje! ',
        fr: 'Tu as un nouveau match ! Envoie-lui un message !',
        nl: 'Je bent gematched met een speler, stuur eens een berichtje!',
        ru: 'Вы подружились с новым игроком, Отправьте ему сообщение!'
      }
    }
  end

  def self.new_message(message = nil)
    {
      headings: {
        de: '✉️ Neue Nachricht !',
        en: '✉️ New message !',
        es: '️️️️️✉️ Nuevo mensaje !',
        fr: '✉️ Nouveau message !',
        nl: '✉️ Nieuw bericht !',
        ru: '✉️ Новое сообщение !'
      },
      contents: {
        de: "Du hast eine neue Nachricht von #{message&.game_profile&.name} erhalten. Vergiss nicht zu antworten!",
        en: "You received a new message from #{message&.game_profile&.name}. Don't forget to answer !",
        es: '',
        fr: "Tu as reçu un nouveau message de #{message&.game_profile&.name}. N'oublie pas de lui répondre !",
        nl: "Je hebt een nieuw bericht van #{message&.game_profile&.name}. Vergeet niet te antwoorden !",
        ru: "Вы получили новое сообщение от #{message&.game_profile&.name}. Не забудьте ответить!"
      }
    }
  end

  def self.new_score_match(game_profile = nil)
    {
      headings: {
        de: '🎯 Gib uns deine Meinung!',
        en: '🎯 Give us your opinion !',
        es: '️️️️️🎯 ¡Danos tu opinión!',
        fr: '🎯 Donne-nous ton avis !',
        nl: '🎯 Geef ons je mening !',
        ru: '🎯 Поделитесь с нами Вашим мнением!'
      },
      contents: {
        de: "Du wurdest letztens mit #{game_profile&.name} gematcht. Gib uns Feedback wie es lief !",
        en: "You recently matched with #{game_profile&.name}. Give us some feedback !",
        es: "Recientemente has emparejado con #{game_profile&.name}. ¡Danos algunos comentarios!",
        fr: "Tu as récemment matché avec #{game_profile&.name}. Dis-nous ce que tu en penses !",
        nl: "Je bent zojuist gematched met #{game_profile&.name}. Geef ons wat feedback !",
        ru: "Вы недавно подружились с #{game_profile&.name}. Оставьте нам отзыв !"
      }
    }
  end

  def self.new_score
    {
      headings: {
        de: '🌟 Neues Feedback!',
        en: '🌟 New feedback !',
        es: '️️️️️🌟 ¡Nuevo comentario!',
        fr: '🌟 Nouvelle recommandation !',
        nl: '🌟 Nieuwe feedback !',
        ru: '🌟 Новый отзыв !'
      },
      contents: {
        de: 'Du hast gerade ein Feedback zu deinem Profil bekommen!',
        en: 'You just received a feedback on your profile !',
        es: '¡Acabas de recibir un comentario en tu perfil!',
        fr: 'Tu viens de recevoir une recommandation !',
        nl: 'Je hebt zojuist feedback gekregen op je account !',
        ru: 'Вы только что получили отзыв в Вашем профиле !'
      }
    }
  end

  def self.new_suggestions(game_profile = nil)
    {
      headings: {
        de: '🔎 Neue Vorschläge verfügbar!',
        en: '🔎 New suggestions available !',
        es: '️️️️️🔎 ¡Nuevas sugerencias disponibles!',
        fr: '🔎 Nouvelles suggestions sont disponibles !',
        nl: '🔎 Nieuwe suggesties verkrijgbaar !',
        ru: '🔎 Доступны новые предложения !'
      },
      contents: {
        de: "Einige Profile mochten #{game_profile&.name} ! Verpasse nicht die Chance, mit ihnen zu matchen!",
        en: "Some profiles liked #{game_profile&.name} ! Don't miss your chance to match with them !",
        es: "¡Algunos perfiles han gustado #{game_profile&.name}! ¡No pierdas la opurtunidad de emparejar con ellos!",
        fr: "Beaucoup de profils ont liké #{game_profile&.name} ! Ne rate pas ton prochain match !",
        nl: "Somige profielen vonden #{game_profile&.name} leuk ! Mis je kans niet om met ze te matchen !",
        ru: "Некоторым профилям понравился #{game_profile&.name} ! Не упустите свой шанс подружиться с ним !"
      }
    }
  end
end
