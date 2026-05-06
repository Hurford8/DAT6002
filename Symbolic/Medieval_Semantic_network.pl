% ---------------------------
% 0) Declarations
% ---------------------------
% --- Add these somewhere near the top ---
:- dynamic isa/2, class_default/3, inst_of/2, inst_value/3.
:- discontiguous inst_of/2.
:- discontiguous inst_value/3.
% ---------------------------
% 1) CLASS HIERARCHY (isa/2)
% ---------------------------

% Root
isa(weapon, thing).

% Primary branches
isa(personal_weapon, weapon).
isa(siege_weapon, weapon).
isa(cbp_weapon, weapon).        % optional: chemical/biological/psychological
isa(ranged_weapon, weapon).
isa(melee_weapon, weapon).

% ---------------------------
% Multi-inheritance bridge layer
% ---------------------------

% Close-combat Personal = Personal + Melee
isa(close_combat_personal, personal_weapon).
isa(close_combat_personal, melee_weapon).

% Close-combat Siege = Siege + Melee
isa(close_combat_siege, siege_weapon).
isa(close_combat_siege, melee_weapon).

% Ranged Personal = Personal + Ranged
isa(ranged_personal, personal_weapon).
isa(ranged_personal, ranged_weapon).

% Ranged Siege = Siege + Ranged
isa(ranged_siege, siege_weapon).
isa(ranged_siege, ranged_weapon).

% ---------------------------------
% Close-combat Personal
% ---------------------------------
%  Bladed Weapons
isa(bladed_hand_weapon, close_combat_personal).
isa(swords, bladed_hand_weapon).
isa(daggers_knives, bladed_hand_weapon).

isa(long_sword, swords).
isa(arming_sword, swords).
isa(broad_swords, swords).
isa(falchions, swords).

isa(rondels, daggers_knives).
isa(stilettos, daggers_knives).
isa(poignards, daggers_knives).
isa(anelaces, daggers_knives).

% Blunt Weapons
isa(blunt_hand_weapon, close_combat_personal).
isa(clubs_maces, blunt_hand_weapon).
isa(hammers, blunt_hand_weapon).

isa(flanged_mace, clubs_maces).
isa(morningstar, clubs_maces).
isa(holy_water_sprinkler, clubs_maces).
isa(flails, clubs_maces).

isa(war_hammer, hammers).
isa(mauls, hammers).
isa(becs_de_corbin, hammers).
isa(horsemen_pick, hammers).

% Polearms
isa(polearm, close_combat_personal).
isa(thrust_family, polearm).
isa(slash_family, polearm).
isa(staff_family, polearm).

isa(javelin, thrust_family).
isa(spears, thrust_family).
isa(winged_spear, thrust_family).
isa(lances, thrust_family).
isa(guisarmes, thrust_family).
isa(pikes, thrust_family).
isa(corseques, thrust_family).

isa(quarterstaves, staff_family).

isa(fauchards, slash_family).
isa(glaives, slash_family).
isa(halberd, slash_family).
isa(danish_axe, slash_family).
isa(sparths, slash_family).
isa(bardiches, slash_family).
isa(pollaxes, slash_family).
isa(franciscas, slash_family).

% ---------------------------------
% Ranged Personal
% ---------------------------------
isa(mechanical_range_personal, ranged_personal).
isa(gunpowder_range_personal, ranged_personal).

isa(bow, mechanical_range_personal).
isa(short_bow, bow).
isa(long_bow, bow).
isa(crossbow, bow).
isa(arbalests, bow).
isa(recurve_bow, bow).
isa(sling, mechanical_range_personal).

isa(trigger_fired,gunpowder_range_personal).
isa(arquebuses, trigger_fired).

isa(ignited_fired, gunpowder_range_personal).
isa(hand_cannon, ignited_fired).

% ---------------------------------
% Ranged Siege/Artillery
% ---------------------------------
isa(artillery_siege, ranged_siege).
isa(pierrier, artillery_siege).

isa(traction_trebuchet, artillery_siege).
isa(counterweight_trebuchets, artillery_siege).
isa(onagers_mangonels, artillery_siege).
isa(ballistas_springalds, artillery_siege).

isa(cannons_siege, ranged_siege).
isa(bombards_siege, cannons_siege).

% ---------------------------------
% Closs-combat Siege
% ---------------------------------
isa(wall_scaler, close_combat_siege).
isa(siege_tower, wall_scaler).

isa(defence_breaker, close_combat_siege).
isa(cat_weasel, defence_breaker).
isa(battering_ram, defence_breaker).
isa(petards, defence_breaker).

% ---------------------------------
% 2) Default Attributes
% ---------------------------------

% safe, Global Default
class_default(weapon, primaryMaterial, unknown).
class_default(weapon, weaponType, unknown).
class_default(weapon, effectiveRange_m, unknown).
class_default(weapon, averageWeight_kg, unknown).
class_default(weapon, eraUsed, unknown).
class_default(weapon, historicalOrigin, unknown).
class_default(weapon, throwableDesigned, false).
class_default(weapon, deliveryMode, unknown).
class_default(weapon, armorEffectiveness, medium).  % neutral default
class_default(weapon, gripType, unknown).
class_default(weapon, projectileType, none).
class_default(weapon, drawMechanism, none).

% Brief-required defaults
class_default(melee_weapon, weaponType, melee).
class_default(melee_weapon, effectiveRange_m, range(0, 3)).
class_default(melee_weapon, deliveryMode, hand_stike).

class_default(ranged_weapon, weaponType, ranged).
class_default(ranged_weapon, effectiveRange_m, range(10, 400)).
class_default(ranged_weapon, deliveryMode, launched).

class_default(siege_weapon, weaponType, siege).
class_default(siege_weapon, effectiveRange_m, range(50, 400)).
% (deliveryMode for siege is launched; will be handled on bridge)

% --- Bridge overrides to remove ambiguity ---
class_default(ranged_siege, weaponType, siege).
class_default(ranged_siege, deliveryMode, launched).
class_default(ranged_siege, effectiveRange_m, range(50, 400)).

class_default(close_combat_siege, weaponType, siege).
class_default(close_combat_siege, deliveryMode, wheeled).
class_default(close_combat_siege, effectiveRange_m, range(0, 3)).

% Your ranged-personal split
class_default(gunpowder_range_personal, deliveryMode, firearm).
class_default(mechanical_range_personal, deliveryMode, launched).

% Materials (broad)
class_default(bladed_hand_weapon, primaryMaterial, set([iron, steel])).
class_default(blunt_hand_weapon, primaryMaterial, set([wood, iron, steel])).
class_default(polearm, primaryMaterial, set([wood, iron, steel])).
class_default(bow, primaryMaterial, set([wood])).
class_default(crossbow, primaryMaterial, set([wood, iron, steel])).
class_default(artillery_siege, primaryMaterial, set([wood, iron])).

% Armor effectiveness (simple, readable defaults)
class_default(bladed_hand_weapon, armorEffectiveness, medium).
class_default(blunt_hand_weapon, armorEffectiveness, high).
class_default(polearm, armorEffectiveness, high).
class_default(gunpowder_range_personal, armorEffectiveness, high).
class_default(artillery_siege, armorEffectiveness, high).

% Grip type defaults (only where it really helps)
class_default(swords, gripType, either).
class_default(arming_sword, gripType, one_handed).
class_default(long_sword, gripType, two_handed).

class_default(blunt_hand_weapon, gripType, one_handed).
class_default(polearm, gripType, two_handed).

% Projectile types (only meaningful for projectile weapons)
class_default(bow, projectileType, arrow).
class_default(crossbow, projectileType, bolt).
class_default(sling, projectileType, stone).

class_default(hand_cannon, projectileType, shot).
class_default(arquebuses, projectileType, shot).
class_default(cannons_siege, projectileType, shot).

% Throwability
% Only override for weapons designed to be thrown
class_default(javelin, throwableDesigned, true).
class_default(franciscas, throwableDesigned, true).

% Drawn Mechanism (bow vs crossbos distinction)
% bows: Drawn by hand
class_default(bow, drawMechanism, hand_drawn).
% Crossbows: spanned/cocked
class_default(crossbow, drawMechanism, cocked).

% ---------------------------------
% 3) Instance example
% ---------------------------------

inst_of(longsword_italian_15c_01, long_sword).

inst_value(longsword_italian_15c_01, primaryMaterial, set([steel])).
inst_value(longsword_italian_15c_01, weaponType, melee).              % could inherit
inst_value(longsword_italian_15c_01, effectiveRange_m, range(1, 2)).   % reach-ish
inst_value(longsword_italian_15c_01, averageWeight_kg, 1.6).
inst_value(longsword_italian_15c_01, eraUsed, '15thC').
inst_value(longsword_italian_15c_01, historicalOrigin, 'Italy').

% Extra attributes (some inherited, but okay to show explicitly)
inst_value(longsword_italian_15c_01, deliveryMode, hand_strike).       % could inherit
inst_value(longsword_italian_15c_01, gripType, two_handed).            % could inherit
inst_value(longsword_italian_15c_01, armorEffectiveness, medium).      % inherits from bladed
inst_value(longsword_italian_15c_01, throwableDesigned, false).        % default
inst_value(longsword_italian_15c_01, projectileType, none).            % default

inst_of(crossbow_english_14c_01, crossbow).

inst_value(crossbow_english_14c_01, primaryMaterial, set([wood, steel])).
inst_value(crossbow_english_14c_01, effectiveRange_m, range(80, 200)).
inst_value(crossbow_english_14c_01, averageWeight_kg, 4.5).
inst_value(crossbow_english_14c_01, eraUsed, '14thC').
inst_value(crossbow_english_14c_01, historicalOrigin, 'England').

inst_of(javelin_roman_01, javelin).

inst_value(javelin_roman_01, averageWeight_kg, 2.0).
inst_value(javelin_roman_01, eraUsed, 'Roman').
inst_value(javelin_roman_01, historicalOrigin, 'Rome').



% ---------------------------------
% 4) REASONING: inheritance + attribute lookup
% ---------------------------------

% is_a(X, C): works for classes and instances
is_a(X, C) :-
    inst_of(X, Direct),
    is_a(Direct, C).
is_a(C, C).
is_a(C, Super) :-
    isa(C, Parent),
    is_a(Parent, Super).

% distance up the hierarchy (used to pick nearest default)
ancestor_distance(C, C, 0).
ancestor_distance(C, A, D) :-
    isa(C, P),
    ancestor_distance(P, A, D0),
    D is D0 + 1.

% closest default up the inheritance chain (handles multiple inheritance)
best_class_default(Class, Prop, Value) :-
    setof(D-V,
          (ancestor_distance(Class, Anc, D),
           class_default(Anc, Prop, V)),
          Pairs),
    Pairs = [MinD-_|_],
    member(MinD-Value, Pairs).

% value(EntityOrClass, Prop, Value): instance overrides > inherited defaults
value(X, Prop, Value) :-
    inst_value(X, Prop, Value), !.
value(X, Prop, Value) :-
    inst_of(X, C),
    best_class_default(C, Prop, Value), !.
value(C, Prop, Value) :-
    best_class_default(C, Prop, Value).

% Convenience predicated
throwable(X) :-
    value(X, throwableDesigned, true).

% A simple "bow or crossbow" test based on drawMechanism
is_bow_like(X) :-
    value(X, drawMechanism, hand_drawn).

is_crossbow_like(X) :-
    value(X, drawMechanism, cocked).

% ----------------------------------
% 5) Sample Queries
% ----------------------------------
%
%  ?- is_a(longsword_italian_15c_01, melee_weapon).
%  ?- value(longsword_italian_15c_01, gripType, G).
%  ?- value(javelin, throwableDesigned, T).
%  ?- throwable(W), is_a(W, weapon).
%  ?- value(crossbow, drawMechanism, M).
%  ?- is_crossbow_like(crossbow).
%  ?- value(ranged_siege, weaponType, WT).
