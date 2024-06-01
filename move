int NextisFood(pSnakeNode pNextNode, pGSnake ps) {
	if (ps->_pFood->x == pNextNode->x && ps->_pFood->y == pNextNode->y) {
		return 1;
	}
	return 0;
}
void EatFood(pSnakeNode pNextNode, pGSnake ps) {
	ps->_pFood->next = ps->_pSnake;
	ps->_pSnake = ps->_pFood;
	free(pNextNode);
	pSnakeNode cur = ps->_pSnake;
	while (cur) {
		SetPos(cur->x, cur->y);
		wprintf(L"%lc", L'●');
		cur = cur->next;
	}
	ps->_Score += ps->_FoodWeight;
	CreateFood(ps);
 
}
void NoFood(pSnakeNode pNextNode, pGSnake ps) {
	pNextNode->next = ps->_pSnake;
	ps->_pSnake = pNextNode;
	pSnakeNode cur = ps->_pSnake;
	while (cur->next->next)
	{
		SetPos(cur->x, cur->y);
		wprintf(L"%lc", BODY);
		cur = cur->next;
 
	}
	SetPos(cur->next->x, cur->next->y);
	printf("  ");
 
	free(cur->next);
	cur->next = NULL;
}
 
void KillByWall(pGSnake ps) {
	if (
		(ps->_pSnake->x == 0) ||
		(ps->_pSnake->x == 58) ||
		(ps->_pSnake->y == 0) ||
		(ps->_pSnake->y == 29)
		) {
		ps->_Status = KILL_BY_WALL;
		return 1;
	}
	return 0;
}
void KillBySelf(pGSnake ps) {
	pSnakeNode cur = ps->_pSnake->next;
	while (cur) {
		if (cur->x == ps->_pSnake->x && cur->y == ps->_pSnake->y) {
			ps->_pSnake = KILL_BY_SELF;
			break;
		}
		cur = cur->next;
	}
 
}
void SnakeMove(pGSnake ps) {
	pSnakeNode pNextNode = (pSnakeNode)malloc(sizeof(SnakeNode));
	switch (ps->_Dir) {
	case UP:
		pNextNode->x = ps->_pSnake->x;
		pNextNode->y = ps->_pSnake->y - 1;
 
		break;
	case DOWN:
		pNextNode->x = ps->_pSnake->x;
		pNextNode->y = ps->_pSnake->y + 1;
		break;
	case LEFT:
		pNextNode->x = ps->_pSnake->x - 2;
		pNextNode->y = ps->_pSnake->y;
 
		break;
	case RIGHT:
		pNextNode->x = ps->_pSnake->x + 2;
		pNextNode->y = ps->_pSnake->y;
		break;
	}
	if (NextisFood(pNextNode,ps)) {
		EatFood(pNextNode, ps);
	}
	else 
	{
		NoFood(pNextNode, ps);
	}
	KillByWall(ps);
	KillBySelf(ps);
}
