function game = preprocess_Charlotte(game)
    game.c_happy = W.nan_equal(game.ChosenEmotion, 2);
    tw = W.nan_equal(game.c_happy, game.Rewarded);
    tl = W.nan_equal(game.c_happy, 1 - game.Rewarded);
    game.winrate_happy = nansum(tw,2)./(nansum(tw,2) + nansum(tl,2));
    game.c_face = W.nan_equal(game.ChosenFaceID, 2);
    tw = W.nan_equal(game.c_face, game.Rewarded);
    tl = W.nan_equal(game.c_face, 1 - game.Rewarded);
    game.winrate_face = nansum(tw,2)./(nansum(tw,2) + nansum(tl,2));

    game.win_emotion = W.prob2choice(game.winrate_happy);
    game.win_face = W.prob2choice(game.winrate_face);

    game.c_emotion_correct = W.nan_equal(game.ChosenEmotion, game.win_emotion);
    game.c_face_correct = W.nan_equal(game.ChosenFaceID, game.win_face);

    idx_emotion = game.cond_block == 0;
    game.c_X(idx_emotion,:) = game.c_happy(idx_emotion,:);
    game.c_X(~idx_emotion,:) = game.c_face(~idx_emotion,:);
    
    game.winrate_X(idx_emotion) = game.winrate_happy(idx_emotion);
    game.winrate_X(~idx_emotion) = game.winrate_face(~idx_emotion);
    
    game.win_X(idx_emotion) = game.win_emotion(idx_emotion);
    game.win_X(~idx_emotion) = game.win_face(~idx_emotion);
    
    game.c_ac_X(idx_emotion,:) = game.c_emotion_correct(idx_emotion,:);
    game.c_ac_X(~idx_emotion,:) = game.c_face_correct(~idx_emotion,:);
end