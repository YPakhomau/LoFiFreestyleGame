:: config
:: todo: universal way
set game_path=c:\dev\WildWorld\generation2\



::code
mklink /D "../client/shared" %game_path%shared
mklink /D "../server/shared" %game_path%shared