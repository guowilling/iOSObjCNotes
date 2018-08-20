
int main()
{
    struct RankRecord
    {
        int no;
        int score;
        char *name;
    };
    /*
    struct RankRecord r1 = {1, "jack", 5000};
    struct RankRecord r2 = {2, "jim", 500};
    struct RankRecord r3 = {3, "jake",300};
     */
    
    struct RankRecord records[3] =
    {
        {1, "jack", 5000},
        
        {2, "jim", 500},
        
        {3, "jake",300}
    };
    
    records[0].no = 4;

    // records[0] = {4, "rose", 9000}; // 错误写法
    
    for (int i = 0; i<3; i++)
    {
        printf("%d\t%s\t%d\n", records[i].no, records[i].name, records[i].score);
    }
    
    //printf("%d\n", sizeof(records));
    
    return 0;
}