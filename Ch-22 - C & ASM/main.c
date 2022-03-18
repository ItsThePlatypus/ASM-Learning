#include <stdio.h>
#include <stdlib.h>
#include <string.h>

extern int rArea(int, int);
extern int rCircum(int, int);

extern double cArea(double);
extern double cCircum(double);
extern double aSum(double [], int);

extern void aDouble(double [], int);
extern void sReverse(char *, int);

void areas();
void strRev();
void arrayManip();

int main(int argc, char *argv, char *envp)
{    
    areas();
    strRev();
    arrayManip();
    return(0);
}

void areas()
{
    int side1, side2, r_area, r_circum;
    double radius, c_area, c_circum;

    puts("Compute area and cicumference of a rectangle");
    printf("Enter the length of one side\n$- ");
    scanf("%d", &side1);
    printf("Enter the length of the other side\n$- ");
    scanf("%d", &side1);
    while(getchar() != '\n');

    r_area = rArea(side1, side2);
    r_circum = rCircum(side1, side2);

    puts("Compute area and cicumference of a circle");
    printf("Enter the radius\n$- ");
    scanf("%lf", &radius);
    while(getchar() != '\n');

    c_area = cArea(radius);
    c_circum = cCircum(radius);

    system("clear");
    printf("***RESULTS***\n\nRectangle Area:\t%d\nRectangle Circumference\t%d\nCircle Area:\t%lf\nCircle Circumference\t%lf\n\n", r_area, r_circum, c_area, c_circum);
    puts("Press Enter to move to the next demonstration...");
    getchar();

    return;
}

void strRev()
{
    char rString[64];

    system("clear");
    puts("Reverse a string");
    printf("Enter a string\n$- ");
    scanf("%s", rString);
    while(getchar() != '\n');

    printf("\nThe string is:\t%s\n", rString);
    sReverse(rString, strlen(rString));
    printf("The reversed string is:\t%s\n", rString);
    
    puts("Press Enter to move to the next demonstration...");
    getchar();

    return;
}

void arrayManip()
{
    double dArray[] = {70.0, 83.2, 91.5, 72.1, 55.5}, sum;
    long int len;
    
    system("clear");
    puts("Some array manipulations...");

    len = sizeof(dArray) / sizeof(double);
    printf("The array has %lu elements\n\n", len);
    printf("The elements of the array are: ");
    for(int i = 0; i < len; i++)
        printf("%.2lf ", dArray[i]);
    putchar('\n');

    sum = aSum(dArray, len);
    printf("The sum of the elements in this array: %.2lf\n\n", sum);

    aDouble(dArray, len);
    printf("The elements of the doubled array are: ");
    for(int i = 0; i < len; i++)
        printf("%.2lf ", dArray[i]);
    putchar('\n');

    sum = aSum(dArray, len);
    printf("The sum of the elements in the doubled array: %.2lf\n\n", sum);

    puts("Press Enter to quit");
    getchar();
    system("clear");

    return;
}