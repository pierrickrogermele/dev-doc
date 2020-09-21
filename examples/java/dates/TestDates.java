import java.time.LocalDateTime;
import java.time.ZonedDateTime;
import java.time.ZoneId;
import java.time.temporal.ChronoUnit;

class TestDates {
	public static void main(String[] args) {

		LocalDateTime localDateTimeBeforeDST = LocalDateTime.of(2018, 3, 25, 1, 55);

		System.out.println(localDateTimeBeforeDST.toString());
		System.out.println(localDateTimeBeforeDST.plus(10, ChronoUnit.MINUTES).toString());

		ZoneId guadeloupeZoneId = ZoneId.of("America/Guadeloupe");
		ZonedDateTime zonedDateTimeBeforeDST = localDateTimeBeforeDST.atZone(guadeloupeZoneId);
		System.out.println(zonedDateTimeBeforeDST.toString());
		System.out.println(zonedDateTimeBeforeDST.plus(10, ChronoUnit.MINUTES).toString());

		ZoneId franceZoneId = ZoneId.of("Europe/Paris");
		zonedDateTimeBeforeDST = localDateTimeBeforeDST.atZone(franceZoneId);
		System.out.println(zonedDateTimeBeforeDST.toString());
		System.out.println(zonedDateTimeBeforeDST.plus(10, ChronoUnit.MINUTES).toString());
	}
}
